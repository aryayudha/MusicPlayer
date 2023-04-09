
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';
import 'package:musicplayer_fita/presentation/state/player/player_cubit.dart';
import 'package:musicplayer_fita/utils/styles.dart';

class MusicItem extends StatefulWidget {
  final Artist artist;
  final int itemIndex;

  const MusicItem({Key? key, required this.artist, required this.itemIndex}) : super(key: key);

  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {

  int currPlayId = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          currPlayId = widget.artist.trackId;
          context.read<PlayerCubit>().emit(PlayerOnPlay(widget.itemIndex, widget.artist));
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 3, 5, 2),
        child: Row(
          children: [
            Image.network(widget.artist.albumArt),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.artist.titleSong, style: UiStyle.titleSmall),
                    Text(widget.artist.artistName, style: UiStyle.bodySmall),
                    Text(widget.artist.albumName, style: UiStyle.labelSmall)
                  ],
                )),
            BlocListener<PlayerCubit, PlayerState>(
              listener: (context, state) {
                if(state is PlayerOnPlay){
                  setState(() {
                    currPlayId = state.songSelected.trackId;
                  });
                }else if(state is PlayerOnStop){
                  setState(() {
                    currPlayId = 0;
                  });
                }
              },
              child: (currPlayId==widget.artist.trackId)?
              const SpinKitWave(
                color: Colors.blue,
                size: 20, type: SpinKitWaveType.center,
              ) : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
