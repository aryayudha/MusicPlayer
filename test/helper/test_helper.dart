import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:musicplayer_fita/data/datasources/api_datasource.dart';
import 'package:musicplayer_fita/domain/repositories/artist_repository.dart';


@GenerateMocks(
  [
    ArtistRepository,
    ApiDatasource
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)]
)

void main(){}