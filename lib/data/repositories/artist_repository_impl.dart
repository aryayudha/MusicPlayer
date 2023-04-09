
import 'package:dartz/dartz.dart';
import 'package:musicplayer_fita/data/datasources/api_datasource.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';
import 'package:musicplayer_fita/domain/repositories/artist_repository.dart';

class ArtistRepositoryImpl implements ArtistRepository {
  final ApiDatasource datasource;

  ArtistRepositoryImpl(this.datasource);

  @override
  Future<Either<String, List<Artist>>> getMusicArtist(String artistName) async {
    try{
      final result = await datasource.getMusicArtist(artistName);
      return Right(result.results!.map((e) => e.toEntity()).toList());
    }catch(e){
      return const Left("Not Found");
    }
  }
}