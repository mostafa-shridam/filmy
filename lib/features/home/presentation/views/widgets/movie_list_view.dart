import 'package:filmy/core/models/movie_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/main_view_model.dart';
import 'movie_list_tile.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.mainViewDataModel,
  });
  final double deviceHeight;
  final double deviceWidth;
  final MainViewDataModel mainViewDataModel;
  @override
  Widget build(BuildContext context) {
    final List<MovieModel> movie = mainViewDataModel.movieModel;

    if (movie.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: movie.length,
          itemBuilder: (context, index) {
            return MovieTile(
              movie: movie[index],
              deviceHeight: deviceHeight,
              deviceWidth: deviceWidth,
            );
          },
        ),
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );
    }
  }
}
