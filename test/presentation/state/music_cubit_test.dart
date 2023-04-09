import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';
import 'package:musicplayer_fita/domain/usecase/get_artist.dart';
import 'package:musicplayer_fita/presentation/state/music/music_cubit.dart';

import 'music_cubit_test.mocks.dart';

@GenerateMocks([GetArtist])
void main(){
  late MockGetArtist mockGetArtist;
  late MusicCubit musicCubit;

  setUp(() {
    mockGetArtist = MockGetArtist();
    musicCubit = MusicCubit(mockGetArtist);
  });

  const testListSong = <Artist>[
    Artist(
        artistName: 'Oasis',
        albumName: "(What's the Story) Morning Glory?",
        albumArt: 'image',
        titleSong: 'Dont look back in anger',
        musicUrl: '',
        trackId: 3334)
  ];

  const artistName = 'Oasis';

  blocTest<MusicCubit, MusicState>(
    'should emit [loading, result] when get data successfully',
    build: () {
      when(mockGetArtist.execute(artistName))
          .thenAnswer((_) async => const Right(testListSong));
      return musicCubit;
    },
    act: (bloc) {
      return bloc.getArtistSong(artistName);
    },
    expect: () => <MusicState>[
      MusicLoading(),
      const MusicResult(testListSong)
    ],
    verify: (bloc){
      verify(mockGetArtist.execute(artistName));
    }
  );

  blocTest<MusicCubit, MusicState>(
      'should emit [loading, empty] when get empty data',
      build: () {
        when(mockGetArtist.execute(artistName))
            .thenAnswer((_) async => const Right([]));
        return musicCubit;
      },
      act: (bloc) {
        return bloc.getArtistSong(artistName);
      },
      expect: () => <MusicState>[
        MusicLoading(),
        MusicEmpty()
      ],
      verify: (bloc){
        verify(mockGetArtist.execute(artistName));
      }
  );

}