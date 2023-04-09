import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer_fita/data/models/artist_music_model.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';

import '../../helper/json_reader.dart';

void main() {

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



  group('to entity', () {
    test('should be a subclass of artist entity', () async {
      final result = tArtistModel.toEntity();
      expect(result, equals(tArtist));
    });
  });

  group('from json', () {
    test('should return valid model from json', () async{
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('data/model/dummy_song_response.json')
      );

      final result = SongModel.fromJson(jsonMap);

      expect(result, equals(tArtistModel));
    });
  });
}

