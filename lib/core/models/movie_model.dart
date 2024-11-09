import 'package:filmy/core/models/app_config_model.dart';
import 'package:get_it/get_it.dart';

class MovieModel {
  final String title;
  final String language;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final bool isAdult;
  final num rating;

  MovieModel({
    required this.title,
    required this.language,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.isAdult,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      language: json['original_language'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      isAdult: json['adult'],
      rating: json['vote_average'],
    );
  }

  String posterUrl() {
    final AppConfigModel appConfig = GetIt.instance.get<AppConfigModel>();
    return "${appConfig.baseImageApiUrl}$posterPath";
  }
}