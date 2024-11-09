import 'package:filmy/core/models/movie_model.dart';
import 'package:filmy/core/services/dio_services.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late DioServices services;

  MovieService() {
    services = getIt.get<DioServices>();
  }

  Future<List<MovieModel>> getPopularMovies({required int page,required String searchCategory}) async {
    try {
      final response = await services.get(path: "movie/$searchCategory", query: {
        "page": page,
      });

      if (response.statusCode == 200) {
        Map data = response.data;
        List<MovieModel> movie = data["results"].map<MovieModel>((movieData) {
          return MovieModel.fromJson(movieData);
        }).toList();
        return movie;
      } else {
        throw Exception(
            "In Movie Service Couldn't get popular movies ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception(
          "In Movie Service Couldn't get popular movies on catch $e");
    }
  }
}
