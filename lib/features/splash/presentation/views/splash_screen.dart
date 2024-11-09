import 'package:flutter/material.dart';

import 'widgets/splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });
  static const String routeName = 'SplashScreen';

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
}
