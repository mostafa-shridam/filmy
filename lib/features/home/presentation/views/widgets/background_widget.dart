import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget(
      {super.key, required this.deviceHeight, required this.deviceWidth});
  final double deviceHeight;
  final double deviceWidth;
  @override
  Widget build(BuildContext context) {
  
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://img.freepik.com/premium-photo/godzilla-eats-king-kong-photography_973275-101802.jpg?w=360",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
