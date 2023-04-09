import 'package:dartz/dartz.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';
import 'package:musicplayer_fita/domain/repositories/artist_repository.dart';

class GetArtist {
  final ArtistRepository repository;

  GetArtist(this.repository);

  Future<Either<String, List<Artist>>> execute(String artist){
    return repository.getMusicArtist(artist);
  }
}