import 'package:filmy/core/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/main_view_model.dart';
import 'main_view_body.dart';
import 'movie_list_tile.dart';

class MovieListView extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MovieModel> movie = mainViewDataModel.movieModel;
    final isLoading = ref.watch(mainViewDataControllerProvider).isLoading;
    if (movie.isNotEmpty) {
      return Expanded(
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              ref.read(mainViewDataControllerProvider.notifier).getMovies();
            }
            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: movie.length,
                  itemBuilder: (context, index) {
                    return MovieTile(
                      movie: movie[index],
                      onTap: () {
                        ref
                            .watch(selectedMovieBackdropPathProvider.notifier)
                            .state = movie[index].posterUrl();
                      },
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                    );
                  },
                ),
              ),
              if (isLoading) ...[
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 24,
                )
              ]
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 3,
            ),
            CircularProgressIndicator(),
          ],
        ),
      );
    }
  }
}
