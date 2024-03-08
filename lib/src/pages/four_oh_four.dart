import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pui/src/components/content_box.dart';

class FourOhFourPage extends StatefulWidget {
  const FourOhFourPage({
    required this.state,
    this.goHomePath = '/',
    this.goHomeLabels = const [
      'Go Home',
      'Skitter Back Home',
      'Return to Home',
      'Okay',
      'Back',
      'Go Back',
      'Return',
      'Go to Home',
    ],
    this.debug = false,
    super.key,
  });
  final GoRouterState state;
  final String goHomePath;
  final List<String> goHomeLabels;
  final bool debug;

  @override
  State<FourOhFourPage> createState() => _FourOhFourPageState();
}

class _FourOhFourPageState extends State<FourOhFourPage> {
  late String _goHomeLabel;
  late bool _debug;
  bool _hoveringOverDebug = false;

  @override
  void initState() {
    super.initState();
    _goHomeLabel =
        widget.goHomeLabels[Random().nextInt(widget.goHomeLabels.length)];
    _debug = widget.debug;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '404!',
              style: TextStyle(
                height: 0.9,
                fontSize: 128,
                fontWeight: FontWeight.w800,
                color:
                    Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Page'),
                const Gap(2),
                ContentBox(
                  elevation: -1.5,
                  child: SelectableText(
                    '${widget.state.uri}',
                    style: const TextStyle(
                      fontFamily: 'packages/pui/JetBrains Mono',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Gap(2),
                const Text('not recognized.')
              ],
            ),
            const Gap(32),
            FilledButton.tonal(
              onPressed: () => context.go(widget.goHomePath),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              child: Text(
                _goHomeLabel,
                textAlign: TextAlign.center,
              ),
            ),
            if (_debug)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _hoveringOverDebug = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _hoveringOverDebug = false;
                    });
                  },
                  child: AnimatedOpacity(
                    duration: 150.ms,
                    curve: Curves.easeInOut,
                    opacity: _hoveringOverDebug ? 1 : 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          child: const Text('Cycle Go Home Labels'),
                          onPressed: () {
                            var index =
                                widget.goHomeLabels.indexOf(_goHomeLabel);
                            if (index == widget.goHomeLabels.length - 1) {
                              index = 0;
                            } else {
                              index++;
                            }

                            index = index % widget.goHomeLabels.length;

                            setState(() {
                              _goHomeLabel = widget.goHomeLabels[index];
                            });
                          },
                        ),
                        const Gap(4),
                        OutlinedButton(
                          child: const Text('Reload Page'),
                          onPressed: () {
                            context.go(
                                '/404${widget.state.uri.toString()[widget.state.uri.toString().length - 1] == '!' ? '' : '!'}');
                          },
                        ),
                        const Gap(4),
                        OutlinedButton(
                          child: const Text('Hide Debug'),
                          onPressed: () {
                            setState(() {
                              _debug = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
