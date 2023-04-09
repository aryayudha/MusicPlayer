import 'package:dartz/dartz.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';

abstract class ArtistRepository {
  Future<Either<String, List<Artist>>> getMusicArtist(String artistName);
}