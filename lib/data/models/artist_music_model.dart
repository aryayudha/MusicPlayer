import 'package:equatable/equatable.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';

class ArtistMusicModel {
  int? resultCount;
  List<SongModel>? results;

  ArtistMusicModel({this.resultCount, this.results});

  ArtistMusicModel.fromJson(Map<String, dynamic> json) {
    resultCount = json['resultCount'];
    if (json['results'] != null) {
      results = <SongModel>[];
      json['results'].forEach((v) {
        results!.add(SongModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultCount'] = resultCount;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongModel extends Equatable {
  final String artistName, collectionName, artWorkUrl60, trackName, previewUrl;
  final int trackId;

  const SongModel(
      {required this.artistName,
      required this.collectionName,
      required this.artWorkUrl60,
      required this.trackName,
      required this.previewUrl,
      required this.trackId});

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        trackId: json['trackId'],
        artistName: json['artistName'],
        collectionName: json['collectionName'],
        trackName: json['trackName'],
        previewUrl: json['previewUrl'],
        artWorkUrl60: json['artworkUrl60'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trackId'] = trackId;
    data['artistName'] = artistName;
    data['collectionName'] = collectionName;
    data['trackName'] = trackName;
    data['previewUrl'] = previewUrl;
    data['artworkUrl60'] = artWorkUrl60;
    return data;
  }

  Artist toEntity() => Artist(
      artistName: artistName,
      albumName: collectionName,
      albumArt: artWorkUrl60,
      titleSong: trackName,
      musicUrl: previewUrl,
      trackId: trackId);

  @override
  List<Object?> get props => [
        artistName,
        collectionName,
        artWorkUrl60,
        trackName,
        previewUrl,
        trackId
      ];
}
