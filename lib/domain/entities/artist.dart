import 'package:equatable/equatable.dart';

class Artist extends Equatable{
  final String artistName, albumName, albumArt, titleSong, musicUrl;
  final int trackId;

  const Artist(
      {required this.artistName,
      required this.albumName,
      required this.albumArt,
      required this.titleSong,
      required this.musicUrl,
        required this.trackId,});

  @override
  List<Object?> get props => [
    artistName,
    albumName,
    albumArt,
    titleSong,
    musicUrl,
    trackId
  ];
}
