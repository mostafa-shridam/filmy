import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget(
      {super.key,
      required this.deviceHeight,
      required this.deviceWidth,
      required this.imageUrl});
  final double deviceHeight;
  final double deviceWidth;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: BoxDecoration(
        image: imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Handle image loading errors
                },
              )
            : null,
        color: imageUrl.isEmpty ? Colors.black : null,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }
}
