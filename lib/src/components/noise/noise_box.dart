import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:open_simplex_2/open_simplex_2.dart';

class NoiseBox extends StatefulWidget {
  const NoiseBox({Key? key}) : super(key: key);

  @override
  createState() => _NoiseBoxState();
}

class _NoiseBoxState extends State<NoiseBox> {
  late final OpenSimplex2 noise;
  ui.Image? noiseImage;
  Size? lastSize;

  @override
  void initState() {
    super.initState();
    noise = OpenSimplex2F(Random().nextInt(1000));
  }

  Future<void> _generateNoiseImage(int width, int height) async {
    const grainScale = 1; // 1 pixel per noise value

    final pixels = Uint32List(width * height);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        // Generate noise and normalize it to [0, 1]
        final noiseValue =
            (noise.noise2(x / grainScale, y / grainScale) + 1) / 2;
        // Map the noise value to alpha, capping the brightest pixels at 25% opacity and scaling down to 0%
        final alpha = (noiseValue * 0.25 * 255).clamp(0, 255).toInt();
        // Apply the alpha value to a black color (could be any color depending on the desired effect)
        pixels[x + y * width] = (alpha << 24); // Only alpha, RGB is black
      }
    }

    final image = await _createImageFromPixels(pixels, width, height);
    if (!mounted) return;
    setState(() {
      noiseImage = image;
    });
  }

  Future<ui.Image> _createImageFromPixels(
      Uint32List pixels, int width, int height) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromPixels(
        pixels.buffer.asUint8List(), width, height, ui.PixelFormat.rgba8888,
        (image) {
      completer.complete(image);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentSize = Size(constraints.maxWidth, constraints.maxHeight);
        if (noiseImage == null || lastSize != currentSize) {
          _generateNoiseImage(
              constraints.maxWidth.floor(), constraints.maxHeight.floor());
          lastSize = currentSize;
        }

        return noiseImage != null
            ? CustomPaint(
                size: currentSize,
                painter: _NoiseImagePainter(noiseImage!),
              )
            : Container();
      },
    );
  }
}

class _NoiseImagePainter extends CustomPainter {
  final ui.Image image;

  _NoiseImagePainter(this.image);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
