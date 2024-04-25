import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    this.size = 20,
    this.strokeWidthRatio = 0.25,
    this.color,
    this.backgroundColor,
    this.value,
    super.key,
  });
  final double size;
  final double strokeWidthRatio;

  final Color? color;
  final Color? backgroundColor;

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: size * strokeWidthRatio,
        strokeCap: StrokeCap.round,
        value: value,
        color: color,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
