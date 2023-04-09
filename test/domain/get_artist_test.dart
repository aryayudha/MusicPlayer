import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';
import 'package:musicplayer_fita/domain/usecase/get_artist.dart';

import '../helper/test_helper.mocks.dart';

void main() {
  late MockArtistRepository mockArtistRepository;
  late GetArtist usecase;

  setUp(() {
    mockArtistRepository = MockArtistRepository();
    usecase = GetArtist(mockArtistRepository);
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

  test('should get song list from the repository',
          () async {
            when(mockArtistRepository.getMusicArtist(artistName))
                .thenAnswer((_) async => const Right(testListSong));

            final result = await usecase.execute(artistName);

            expect(result, equals(const Right(testListSong)));
          }
  );
}
