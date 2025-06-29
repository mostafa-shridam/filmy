import 'dart:convert';

import 'package:filmy/core/models/app_config_model.dart';
import 'package:filmy/core/services/dio_services.dart';
import 'package:filmy/core/services/movie_service.dart';
import 'package:filmy/core/services/video_player_service.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void setupGetIt() async {
  final getIt = GetIt.instance;
  final configFile = await rootBundle.loadString("assets/config/main.json");
  final configData = jsonDecode(configFile);
  getIt.registerSingleton<AppConfigModel>(
    AppConfigModel(
      apiKey: configData["API_KEY"],
      baseImageApiUrl: configData["BASE_IMAGE_API_URL"],
      baseApiUrl: configData["BASE_API_URL"],
    ),
  );

  getIt.registerSingleton<DioServices>(DioServices());
  getIt.registerSingleton<MovieService>(MovieService());
  getIt.registerSingleton<VideoPlayerService>(VideoPlayerService.instance);
}
