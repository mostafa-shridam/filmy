import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:filmy/core/models/app_config_model.dart';
import 'package:get_it/get_it.dart';

class DioServices {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;
  late String apiKey;
  late String baseApiUrl;

  DioServices() {
    AppConfigModel config = getIt.get<AppConfigModel>();
    apiKey = config.apiKey;
    baseApiUrl = config.baseApiUrl;
  }

  Future<Response> get(
      {required String path, Map<String, dynamic>? query}) async {
    try {
      String url = "$baseApiUrl$path";
      Map<String, dynamic> resultQuery = {
        "api_key": apiKey,
        "language": "en-US",
      };
      if (query != null) {
        resultQuery.addAll(query);
      }
      return await dio.get(url, queryParameters: resultQuery); // Use resultQuery here
    } on DioException catch (e) {
      log('In Dio Services Exception'); // Corrected typo
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception('DioException occurred without a response: $e');
      }
    }
  }
}