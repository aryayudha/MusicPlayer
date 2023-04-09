
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';
import 'package:musicplayer_fita/presentation/state/music/music_cubit.dart';
import 'package:musicplayer_fita/utils/styles.dart';

import '../state/player/player_cubit.dart';

class PlayerAction extends StatefulWidget {
  const PlayerAction({Key? key}) : super(key: key);

  @override
  State<PlayerAction> createState() => _PlayerActionState();
}

class _PlayerActionState extends State<PlayerAction> {
  List<Artist> songList = [];
  int selectedIndex = 0;
  String artistName = '';
  String titleSong = '';
  String albumArt = '';
  bool isPlay = false;
  Duration musicDuration = const Duration();
  Duration positionDuration = const Duration();
  final _player = audio.AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<PlayerCubit, PlayerState>(
            listener: (_, state) async {
              if(state is PlayerOnPlay){
                setState(() {
                  artistName = state.songSelected.artistName;
                  titleSong = state.songSelected.titleSong;
                  albumArt = state.songSelected.albumArt;
                  isPlay = true;
                  selectedIndex = state.index;
                });
                await _player.play(audio.UrlSource(state.songSelected.musicUrl));
                //await _player.play(audio.UrlSource(songList[selectedIndex].musicUrl));
                _player.onDurationChanged.listen((event) {setState(() {
                  musicDuration = event;
                });});
                _player.onPositionChanged.listen((event) {setState(() {
                  positionDuration = event;
                });});
                _player.onPlayerComplete.listen((event) {
                  setState(() {
                    isPlay = false;
                    positionDuration = Duration.zero;
                    context.read<PlayerCubit>().emit(PlayerOnStop());
                  });
                });
              }
            }),
          BlocListener<MusicCubit, MusicState>(
            listener: (_,state){
              if(state is MusicResult){
                setState(() {
                  songList = state.res;
                });
              }
          })
        ],
        child: BlocBuilder<PlayerCubit, PlayerState>(
          builder: (_, state) {
            if (state is PlayerOnPlay) {
              return Container(
                height: 70,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.blue[800]!, Colors.lightBlueAccent]),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(albumArt),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            titleSong,
                            style: UiStyle.titleSmall.copyWith(
                                color: Colors.white, fontSize: 16),
                            maxLines: 1,
                          ),
                          Text(
                            artistName,
                            style: UiStyle.bodySmall.copyWith(
                                color: Colors.white, fontSize: 11),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                                trackHeight: 2.5
                            ),
                            child: SizedBox(
                              height: 20,
                              child: Slider(
                                  max: musicDuration.inSeconds.toDouble(),
                                  value: positionDuration.inSeconds.toDouble(),
                                  thumbColor: Colors.blue,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.blueGrey,
                                  onChanged: (value) {
                                    final duration = musicDuration;
                                    final position =
                                        value * duration.inMilliseconds;
                                    _player.seek(
                                        Duration(milliseconds: position.round()));
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: (selectedIndex>0)? () {
                          context.read<PlayerCubit>().emit(PlayerOnPlay(selectedIndex-1, songList[selectedIndex-1]));
                        } : null,
                        disabledColor: Colors.grey,
                        icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
                    IconButton(
                        onPressed: (isPlay&&positionDuration.inMilliseconds>0)? () {
                          _pause();
                        } : (){_play();},
                        icon: Icon((isPlay&&positionDuration.inMilliseconds>0)?
                        Icons.pause :
                        Icons.play_circle_outline_rounded, color: Colors.white),
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1)),
                    IconButton(
                        onPressed: (selectedIndex<songList.length-1)? () {
                          context.read<PlayerCubit>().emit(PlayerOnPlay(selectedIndex+1, songList[selectedIndex+1]));
                        } : null,
                        icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                        disabledColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
                  ],
                ),
              );
            } else {
              return Container(height: 1);
            }
          },
        ));
  }

  Future<void> _play() async {
    final position = positionDuration;
    if (position.inMilliseconds > 0) {
      await _player.seek(position);
    }
    await _player.resume();
    setState(() {
      isPlay = true;
    });
  }

  Future<void> _pause() async {
    await _player.pause();
    setState(() {
      isPlay = false;
    });
  }
}
