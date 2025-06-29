import 'dart:developer';

import 'package:filmy/core/models/main_view_model.dart';
import 'package:filmy/core/models/movie_model.dart';
import 'package:filmy/core/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/presentation/views/widgets/search_category.dart';

class MainViewController extends StateNotifier<MainViewDataModel> {
  MainViewController([MainViewDataModel? state])
      : super(state ?? MainViewDataModel.intial()) {
    // Corrected method name
    getMovies();
  }

  final MovieService movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies({String? searchCategory}) async {
    try {
      log('MainViewController: Fetching movies for category: ${searchCategory ?? SearchCategory.popular}');

      // Set loading state
      state = state.copyWith(isLoading: true);

      // Directly await the result without initializing an empty list
      List<MovieModel> movies = await movieService.getPopularMovies(
        page: state.page,
        searchCategory: searchCategory ?? SearchCategory.popular,
      );

      log('MainViewController: Successfully fetched ${movies.length} movies');

      // Update the state with the new list of movies and increment the page
      state = state.copyWith(
        movieModel: movies, // Replace the list instead of appending
        page: state.page + 1,
        searchCategory: searchCategory ?? state.searchCategory,
        isLoading: false, // Clear loading state
      );

      log('MainViewController: State updated successfully');
    } catch (e) {
      log('MainViewController Error: $e');
      // Clear loading state on error
      state = state.copyWith(isLoading: false);
      // Keep the current state but log the error
      // You could also update the state to show an error message to the user
    }
  }

  void searchMovie({required String searchText}) {
    log('MainViewController: Searching for: $searchText');

    if (searchText.isEmpty) {
      // Reset to original movies when search is cleared
      log('MainViewController: Clearing search, resetting to original movies');
      getMovies(searchCategory: state.searchCategory);
    } else {
      // Filter existing movies for search
      final filteredMovies = state.movieModel
          .where((movie) =>
              movie.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();

      log('MainViewController: Found ${filteredMovies.length} movies matching search');

      state = state.copyWith(
        searchText: searchText,
        movieModel: filteredMovies,
      );
    }
  }
}
