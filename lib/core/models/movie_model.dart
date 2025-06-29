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
  final String? videoUrl;

  MovieModel({
    required this.title,
    required this.language,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.isAdult,
    required this.rating,
    this.videoUrl,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title']?.toString() ?? 'Unknown Title',
      language: json['original_language']?.toString() ?? 'en',
      overview: json['overview']?.toString() ?? 'No overview available',
      posterPath: json['poster_path']?.toString() ?? '',
      backdropPath: json['backdrop_path']?.toString() ?? '',
      releaseDate: json['release_date']?.toString() ?? 'Unknown',
      isAdult: json['adult']?.toString().toLowerCase() == 'true' ||
          json['adult'] == true,
      rating: json['vote_average']?.toDouble() ?? 0.0,
      videoUrl: json['video_url']?.toString(),
    );
  }

  String posterUrl() {
    final AppConfigModel appConfig = GetIt.instance.get<AppConfigModel>();
    if (posterPath.isEmpty) {
      return 'https://via.placeholder.com/300x450?text=No+Image';
    }
    return "${appConfig.baseImageApiUrl}$posterPath";
  }

  String? getVideoUrl() {
    return videoUrl;
  }
}
