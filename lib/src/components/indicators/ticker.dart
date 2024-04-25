import 'dart:async';

import 'package:flutter/material.dart';

class Ticker extends StatefulWidget {
  const Ticker({
    this.forceAngle,
    this.tickerDuration = const Duration(seconds: 1),
    super.key,
  });
  final int? forceAngle;
  final Duration tickerDuration;

  @override
  createState() => _TickerState();
}

class _TickerState extends State<Ticker> {
  Timer? _timer;

  int _rotation = 0; // 0 - 3

  @override
  void initState() {
    super.initState();

    _updateValues();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateValues() {
    if (widget.forceAngle != null) {
      _rotation = widget.forceAngle!;
    } else {
      _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _rotation = (_rotation + 1) % 4;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateValues();

    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        ),
        color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
      ),
      child: Center(
        child: Transform.rotate(
          angle: _rotation * 1.5708 / 2,
          child: Container(
            width: 32,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}
