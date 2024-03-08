import 'dart:math';

import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({
    required this.child,
    this.elevation = 1,
    this.padding = const EdgeInsets.all(8),
    super.key,
  });
  final Widget child;
  final double elevation;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isNegativeElevation = elevation < 0;
    final absolutionElevation = elevation.abs();

    final colorScheme = Theme.of(context).colorScheme;
    final baseBackgroundColor =
        isNegativeElevation ? colorScheme.shadow : colorScheme.surface;
    final baseForegroundColor =
        isNegativeElevation ? colorScheme.surfaceTint : colorScheme.outline;

    var backgroundColor = baseBackgroundColor.withOpacity(
      min(1, max(0, absolutionElevation * 0.5)),
    );
    var outlineColor = baseForegroundColor.withOpacity(
      min(1, max(0, absolutionElevation * 0.3)),
    );

    if (isNegativeElevation) {
      backgroundColor = baseBackgroundColor.withOpacity(
        min(1, max(0, absolutionElevation * 0.75)),
      );
      outlineColor = outlineColor.withOpacity(
        outlineColor.opacity * 0.5,
      );
    }

    return Card(
      elevation: elevation.abs(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: outlineColor,
        ),
      ),
      color: backgroundColor,
      shadowColor:
          isNegativeElevation ? Colors.transparent : colorScheme.shadow,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
