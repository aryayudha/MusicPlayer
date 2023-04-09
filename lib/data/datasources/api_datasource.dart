import 'dart:convert';

import '../models/artist_music_model.dart';
import 'package:http/http.dart' as http;

abstract class ApiDatasource {
  Future<ArtistMusicModel> getMusicArtist(String artistName);
}

class ApiDatasourceImpl implements ApiDatasource {
  final http.Client client;

  ApiDatasourceImpl({required this.client});

  @override
  Future<ArtistMusicModel> getMusicArtist(String artistName) async{
    final qParams = {
      'media': "music",
      'term': artistName
    };
    var uri = Uri.https('itunes.apple.com','/search',qParams);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      return ArtistMusicModel.fromJson(json.decode(response.body));
    }else{
      throw {};
    }
  }
}