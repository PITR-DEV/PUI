import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NumEditor extends StatefulWidget {
  const NumEditor({
    required this.value,
    this.onChanged,
    this.sensitivityMultiplier = 0.125,
    this.decimalPlaces = 2,
    super.key,
  });
  final num value;
  final Function(num)? onChanged;
  final num sensitivityMultiplier;
  final int decimalPlaces;

  @override
  createState() => _NumEditorState();
}

class _NumEditorState extends State<NumEditor> {
  late final TextEditingController _controller;

  bool _pressedDown = false;
  bool _isInvalid = false;
  double? _pendingRawDelta;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final typeColor = getTypeColor(widget.value.runtimeType);
    final backgroundColor = HSLColor.fromColor(typeColor)
        .withLightness(_pressedDown ? 0.3 : 0.2)
        .toColor()
        .harmonizeWith(colorScheme.primary)
        .withOpacity(_pressedDown ? 1 : 0.75);
    final foregroundColor = typeColor.harmonizeWith(colorScheme.primary);

    final typeLetter = getTypeLetter(widget.value.runtimeType);
    var displayValue = _pendingRawDelta == null
        ? widget.value
        : computeValue(widget.value, _pendingRawDelta!);

    var displayText = widget.value is double
        ? displayValue.toStringAsFixed(widget.decimalPlaces)
        : displayValue.toString();

    if (_controller.text != displayText) {
      _controller.text = displayText;
      _isInvalid = false;
    }

    return Row(
      children: [
        MouseRegion(
          cursor: widget.onChanged == null
              ? MouseCursor.defer
              : SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            onHorizontalDragStart: (details) {
              if (widget.onChanged == null) return;
              setState(() {
                _pressedDown = true;
                _pendingRawDelta = 0;
              });
            },
            onHorizontalDragEnd: (details) {
              if (widget.onChanged == null) return;

              if (_pendingRawDelta != null) {
                final newValue = computeValue(widget.value, _pendingRawDelta!);

                if (widget.value != newValue) {
                  widget.onChanged!(newValue);
                }
              }

              setState(() {
                _pressedDown = false;
                _pendingRawDelta = null;
              });
            },
            onHorizontalDragUpdate: (details) {
              if (widget.onChanged == null) return;
              if (_pendingRawDelta == null) return;

              final delta = details.primaryDelta!;

              setState(() {
                _pendingRawDelta = _pendingRawDelta! + delta;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: typeColor.withOpacity(_pressedDown ? 1 : 0.5),
                  width: 1,
                ),
              ),
              height: 24,
              width: 24,
              child: Center(
                child: Text(
                  typeLetter,
                  style: TextStyle(
                    fontFamily: 'packages/pui/JetBrains Mono',
                    color: foregroundColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(4),
        Expanded(
          child: TextField(
            controller: _controller,
            enabled: !_pressedDown,
            readOnly: widget.onChanged == null,
            onChanged: (value) {
              if (widget.onChanged == null) return;

              final newValue = num.tryParse(value);

              if (newValue != null) {
                widget.onChanged!(newValue);
                if (_isInvalid) {
                  setState(() {
                    _isInvalid = false;
                  });
                }
              } else {
                setState(() {
                  _isInvalid = true;
                });
              }
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              error: _isInvalid ? SizedBox() : null,
            ),
            style: TextStyle(
              fontFamily: 'packages/pui/JetBrains Mono',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  num computeValue(num value, double rawDelta) {
    final delta = rawDelta * widget.sensitivityMultiplier;

    if (value is int) {
      return (value + delta).round();
    }

    return (value + delta).toDouble();
  }

  Color getTypeColor(Type type) {
    if (type == int) return Colors.blue;
    if (type == double) return const Color.fromARGB(255, 93, 214, 140);
    return Colors.black;
  }

  String getTypeLetter(Type type) {
    if (type == int) return 'i';
    if (type == double) return 'f';
    return 'N';
  }
}
