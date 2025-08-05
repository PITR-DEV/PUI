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

    var backgroundColor = baseBackgroundColor.withValues(
      alpha: min(1, max(0, absolutionElevation * 0.5)),
    );
    var outlineColor = baseForegroundColor.withValues(
      alpha: min(1, max(0, absolutionElevation * 0.3)),
    );

    if (isNegativeElevation) {
      backgroundColor = baseBackgroundColor.withValues(
        alpha: min(1, max(0, absolutionElevation * 0.75)),
      );
      outlineColor = outlineColor.withValues(
        alpha: outlineColor.a * 0.5,
      );
    } else if (elevation == 0) {
      outlineColor = colorScheme.outline.withValues(
        alpha: 0.3,
      );
    }

    final resultElevation = isNegativeElevation
        ? min(5.0, max(0.0, 5 - absolutionElevation))
        : absolutionElevation;

    return Card(
      elevation: resultElevation,
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

class ContentBoxButton extends StatefulWidget {
  const ContentBoxButton({
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.padding = const EdgeInsets.all(8),
    this.elevation = 1,
    this.pressedElevation = -2,
    this.hoverElevation = 4,
    this.disabledElevation = 0,
    super.key,
  });
  final Widget child;
  final VoidCallback? onPressed;

  final bool enabled;

  final EdgeInsets padding;
  final double elevation;
  final double pressedElevation;
  final double hoverElevation;
  final double disabledElevation;

  @override
  createState() => _ContentBoxButtonState();
}

class _ContentBoxButtonState extends State<ContentBoxButton> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _enabled ? _onTap : null,
      onTapDown: _enabled ? (_) => _setPressed(true) : null,
      onTapUp: _enabled ? (_) => _setPressed(false) : null,
      onTapCancel: _enabled ? () => _setPressed(false) : null,
      child: MouseRegion(
        onEnter: _enabled ? (_) => _setHover(true) : null,
        onExit: _enabled ? (_) => _setHover(false) : null,
        cursor: _enabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: ContentBox(
          elevation: _elevation,
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }

    _setPressed(false);
  }

  void _setHover(bool hover) {
    if (_hover != hover) {
      setState(() {
        _hover = hover;
      });
    }
  }

  void _setPressed(bool pressed) {
    if (_pressed != pressed) {
      setState(() {
        _pressed = pressed;
      });
    }
  }

  bool get _enabled => widget.onPressed != null && widget.enabled;

  double get _elevation => _enabled
      ? (_pressed
          ? widget.pressedElevation
          : _hover
              ? widget.hoverElevation
              : widget.elevation)
      : widget.disabledElevation;
}
