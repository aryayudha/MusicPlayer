import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musicplayer_fita/data/models/artist_music_model.dart';
import 'package:musicplayer_fita/data/repositories/artist_repository_impl.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';

import '../../helper/test_helper.mocks.dart';

void main(){
  late MockApiDatasource mockApiDatasource;
  late ArtistRepositoryImpl repositoryImpl;

  setUp(() {
    mockApiDatasource = MockApiDatasource();
    repositoryImpl = ArtistRepositoryImpl(mockApiDatasource);
  });

  const tArtistModel = SongModel(
      artistName: 'Oasis',
      collectionName: "(What's the Story) Morning Glory?",
      artWorkUrl60: 'image',
      trackName: 'Dont look back in anger',
      previewUrl: '',
      trackId: 3334
  );

  const tArtist = Artist(
      artistName: 'Oasis',
      albumName: "(What's the Story) Morning Glory?",
      albumArt: 'image',
      titleSong: 'Dont look back in anger',
      musicUrl: '',
      trackId: 3334);

  group('get artist song', () {
    const tArtistName = 'oasis';

    // test('should return data source', () {
    //   when(mockApiDatasource.getMusicArtist(tArtistName))
    //       .thenAnswer((_) async => tArtistModel);
    // });
  });
}