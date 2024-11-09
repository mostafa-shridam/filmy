import 'package:flutter/material.dart';

import '../../features/home/presentation/views/main_view.dart';
import '../../features/splash/presentation/views/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MainScreen());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
