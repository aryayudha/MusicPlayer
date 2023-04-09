import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musicplayer_fita/data/datasources/api_datasource.dart';
import 'package:musicplayer_fita/data/models/artist_music_model.dart';
import 'package:http/http.dart' as http;

import '../../helper/json_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main(){
  late MockHttpClient mockHttpClient;
  late ApiDatasourceImpl datasourceImpl;
  
  setUp(() {
    mockHttpClient = MockHttpClient();
    datasourceImpl = ApiDatasourceImpl(client: mockHttpClient);
  });
  
  group('get data artist', () { 
    const tArtistName = 'oasis';
    final tArtistModel = ArtistMusicModel.fromJson(json.decode(
      readJson('helper/dummy_response.json')));
    final qParams = {
      'media': "music",
      'term': tArtistName
    };
    var uri = Uri.https('itunes.apple.com','/search',qParams);
    test('should return artist model when 200', () async {
      when(
        mockHttpClient.get(uri)
      ).thenAnswer((_) async=> http.Response(
        readJson('helper/dummy_response.json'),200
      ));

      final result = await datasourceImpl.getMusicArtist(tArtistName);

      expect(result, equals(tArtistModel));
    });
  });
}