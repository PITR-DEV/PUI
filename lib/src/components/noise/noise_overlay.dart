import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class NoiseOverlay extends StatelessWidget {
  const NoiseOverlay({
    this.opacity = 0.025,
    this.colored = true,
    this.scale = 1,
    super.key,
  });
  final double opacity;
  final bool colored;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final isCleanScale = scale % 1 == 0;

    return IgnorePointer(
      child: BackdropFilter(
        filter: ui.ImageFilter.compose(
          outer: ui.ImageFilter.blur(
            sigmaX: 0.0,
            sigmaY: 0.0,
          ),
          inner: ui.ImageFilter.matrix(
            Matrix4.diagonal3Values(1.0, 1.0, 1.0).storage,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'packages/pui/assets/noise/noise_256_${colored ? 'colored' : 'monochrome'}.webp',
              ),
              scale: 1 / scale,
              filterQuality:
                  isCleanScale ? ui.FilterQuality.none : ui.FilterQuality.high,
              fit: BoxFit.none,
              alignment: Alignment.topLeft,
              repeat: ImageRepeat.repeat,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(opacity),
                BlendMode.modulate,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
