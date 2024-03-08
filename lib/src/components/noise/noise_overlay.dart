import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class NoiseOverlay extends StatelessWidget {
  const NoiseOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.compose(
        outer: ui.ImageFilter.blur(
            sigmaX: 0.0, sigmaY: 0.0), // No blur, adjust if desired
        inner: ui.ImageFilter.matrix(
          Matrix4.diagonal3Values(1.0, 1.0, 1.0)
              .storage, // Identity matrix, no transformation
          filterQuality: FilterQuality.high,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          // Overlay noise texture with additive blending
          image: DecorationImage(
            image: AssetImage(
              'packages/pui/assets/noise/noise_4096_colored.png',
            ), // Path to your noise texture
            fit: BoxFit.none,
            alignment: Alignment.topLeft,
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.025),
              BlendMode.modulate,
            ),
            // opacity: 0.125,
          ),
        ),
      ),
    );
  }
}
