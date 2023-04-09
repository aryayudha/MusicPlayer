
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musicplayer_fita/presentation/state/music/music_cubit.dart';
import 'package:musicplayer_fita/presentation/widget/music_item.dart';

import '../../utils/styles.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.blue,
          pinned: true,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.fromLTRB(15, 0, 20, 10),
            expandedTitleScale: 1,
            centerTitle: false,
            title: _appTitle(context),
            background: _bgAppbar(context),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<MusicCubit, MusicState>(builder: (_, state){
            if(state is MusicInitial){
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                        'https://cdn-icons-png.flaticon.com/512/1072/1072189.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Text('Please search by artist name', style: UiStyle.titleSmall.copyWith(
                      fontSize: 16
                    )),
                  ],
                ),
              );
            } else if(state is MusicResult){
              return ListView.separated(
                separatorBuilder: (_,index)=> const Divider(
                  color: Colors.blueGrey,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                shrinkWrap: true,
                primary: false,
                itemCount: state.res.length,
                itemBuilder: (_, index) {
                  return MusicItem(artist: state.res[index], itemIndex: index);
                }
              );
            } else if(state is MusicLoading){
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SpinKitWave(
                      color: Colors.blue,
                      size: 60,
                    ),
                    Text('Loading data ...',
                        style: UiStyle.titleSmall.copyWith(fontSize: 16)),
                  ],
                ),
              );
            } else{
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/678/678625.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Text('Uhh no, empty result data ...',
                        style: UiStyle.titleSmall.copyWith(fontSize: 16
                    )),
                  ],
                ),
              );
            }
          }),
        )
      ],
    );
  }

  Widget _appTitle(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: UiStyle.formTextRounded.copyWith(
          fillColor: Colors.white,
          hintText: "Search Artist",
          hintStyle: const TextStyle(fontSize: 12),
          prefixIcon: const Icon(Icons.search_outlined, size: 20.0),
        ),
        keyboardType: TextInputType.text,
        onFieldSubmitted: (value){
          context.read<MusicCubit>().getArtistSong(value);
        },
      ),
    );
  }

  Widget _bgAppbar(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 8),
      child: Text('Fita Music App', style: UiStyle.titleSmall.copyWith(color: Colors.white, fontSize: 18)),
    );
  }
}
