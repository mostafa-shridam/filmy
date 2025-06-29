import 'package:filmy/core/models/movie_model.dart';
import 'package:filmy/core/services/dio_services.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late DioServices services;

  MovieService() {
    services = getIt.get<DioServices>();
  }

  Future<List<MovieModel>> getPopularMovies(
      {required int page, required String searchCategory}) async {
    try {
      log('Fetching movies for category: $searchCategory, page: $page');

      final response =
          await services.get(path: "movie/$searchCategory", query: {
        "page": page,
      });

      if (response.statusCode == 200) {
        Map data = response.data;

        if (data["results"] == null) {
          log('No results found in API response');
          return [];
        }

        List<MovieModel> movie = data["results"].map<MovieModel>((movieData) {
          try {
            // Add default video URL for testing
            movieData['video_url'] =
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
            return MovieModel.fromJson(movieData);
          } catch (e) {
            log('Error parsing movie data: $e');
            log('Movie data: $movieData');
            // Return a default movie model if parsing fails
            return MovieModel(
              title: movieData['title']?.toString() ?? 'Unknown Title',
              language: movieData['original_language']?.toString() ?? 'en',
              overview:
                  movieData['overview']?.toString() ?? 'No overview available',
              posterPath: movieData['poster_path']?.toString() ?? '',
              backdropPath: movieData['backdrop_path']?.toString() ?? '',
              releaseDate: movieData['release_date']?.toString() ?? 'Unknown',
              isAdult: false,
              rating: 0.0,
              videoUrl:
                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            );
          }
        }).toList();

        log('Successfully fetched ${movie.length} movies');
        return movie;
      } else {
        log('API Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception(
            "In Movie Service Couldn't get popular movies ${response.statusMessage}");
      }
    } catch (e) {
      log('Movie Service Error: $e');
      throw Exception(
          "In Movie Service Couldn't get popular movies on catch $e");
    }
  }
}
