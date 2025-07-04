import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/models/movie_model.dart';
import '../../../../../features/video_player/presentation/views/video_player_screen.dart';

class MovieTile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  MovieTile({
    super.key,
    required this.movie,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.onTap,
  });
  final Function() onTap;
  final MovieModel movie;
  final double deviceHeight;
  final double deviceWidth;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: deviceHeight * 0.02),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: deviceHeight * 0.28,
                  width: deviceWidth * 0.38,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(6),
                      bottomStart: Radius.circular(6),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(movie.posterUrl()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (movie.videoUrl != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _playVideo(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(6),
                    bottomEnd: Radius.circular(6),
                  ),
                  color: Colors.black12,
                ),
                height: deviceHeight * 0.28,
                width: deviceWidth,
                child: ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        movie.rating.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${movie.language.toUpperCase()} | ${movie.releaseDate}\nAdult : ${movie.isAdult}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Text(
                        movie.overview,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playVideo(BuildContext context) {
    if (movie.videoUrl != null) {
      Navigator.pushNamed(
        context,
        VideoPlayerScreen.routeName,
        arguments: {
          'videoUrl': movie.videoUrl!,
          'title': movie.title,
          'posterUrl': movie.posterUrl(),
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد فيديو متاح لهذا الفيلم'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
