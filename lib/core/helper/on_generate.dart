import 'package:flutter/material.dart';

import '../../features/home/presentation/views/main_view.dart';
import '../../features/splash/presentation/views/splash_screen.dart';
import '../../features/video_player/presentation/views/video_player_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case VideoPlayerScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoUrl: args['videoUrl'],
          title: args['title'],
          posterUrl: args['posterUrl'],
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
