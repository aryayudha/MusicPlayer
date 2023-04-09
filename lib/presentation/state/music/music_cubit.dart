import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/artist.dart';
import '../../../domain/usecase/get_artist.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  final GetArtist getArtist;

  MusicCubit(this.getArtist) : super(MusicInitial());

  void getArtistSong(String artist) async {
    emit(MusicLoading());
    final res = await getArtist.execute(artist);
    res.fold(
        (l) => {emit(MusicEmpty())},
        (r) => {
          if (r.isEmpty) {emit(MusicEmpty())}
          else {emit(MusicResult(r))}});
  }
}
