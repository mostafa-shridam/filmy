import 'dart:developer';

import 'package:filmy/core/models/main_view_model.dart';
import 'package:filmy/core/models/movie_model.dart';
import 'package:filmy/core/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/presentation/views/widgets/search_category.dart';

class MainViewController extends StateNotifier<MainViewDataModel> {
  MainViewController([MainViewDataModel? state])
      : super(state ?? MainViewDataModel.intial()) { // Corrected method name
    getMovies();
  }

  final MovieService movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies({ String? searchCategory}) async {
    try {
      // Directly await the result without initializing an empty list
      List<MovieModel> movies = await movieService.getPopularMovies(page: state.page, searchCategory: searchCategory ?? SearchCategory.popular,);
      
      // Update the state with the new list of movies and increment the page
      state = state.copyWith(
        movieModel: [...state.movieModel, ...movies], // Using spread operator for clarity
        page: state.page + 1,
      );
    } catch (e) {
      log(e.toString());
      // Optionally, you could update the state to reflect an error
      // state = state.copyWith(error: e.toString()); // Assuming MainViewDataModel has an error field
    }
  }
}