

import 'package:get_it/get_it.dart';
import 'package:musicplayer_fita/data/datasources/api_datasource.dart';
import 'package:musicplayer_fita/data/repositories/artist_repository_impl.dart';
import 'package:musicplayer_fita/domain/repositories/artist_repository.dart';
import 'package:musicplayer_fita/domain/usecase/get_artist.dart';
import 'package:musicplayer_fita/presentation/state/music/music_cubit.dart';
import 'package:musicplayer_fita/presentation/state/player/player_cubit.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init(){
  //client
  locator.registerLazySingleton(()=> http.Client());
  //bloc
  locator.registerFactory(() => PlayerCubit());
  locator.registerFactory(() => MusicCubit(locator()));

  //usecase
  locator.registerLazySingleton(() => GetArtist(locator()));

  //repository
  locator.registerLazySingleton<ArtistRepository>(() => ArtistRepositoryImpl(locator()));

  //data
  locator.registerLazySingleton<ApiDatasource>(()=> ApiDatasourceImpl(client: locator()));
}