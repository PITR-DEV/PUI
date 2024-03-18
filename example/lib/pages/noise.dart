import 'package:example/providers/noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:pui/pui.dart';

class NoisePage extends ConsumerStatefulWidget {
  const NoisePage({super.key});

  @override
  createState() => _NoisePageState();
}

class _NoisePageState extends ConsumerState<NoisePage> {
  double _width = 256;
  double _height = 256;

  @override
  Widget build(BuildContext context) {
    const divide = Divider(
      height: 32,
      thickness: 1,
    );

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              'Noise Overlay',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            leading: Switch(
              value: ref.watch(providerGlobalNoiseEnabled),
              onChanged: (value) {
                ref.read(providerGlobalNoiseEnabled.notifier).state = value;
              },
            ),
          ),
          const Gap(4),
          Text(
            'Colored',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ListTile(
            leading: Switch(
              value: ref.watch(providerGlobalNoiseColored),
              onChanged: (value) {
                ref.read(providerGlobalNoiseColored.notifier).state = value;
              },
            ),
          ),
          ListTile(
            title: const Text('Opacity'),
            subtitle: SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Row(
                children: [
                  Slider(
                    value: ref.watch(providerGlobalNoiseOpacity),
                    min: 0,
                    max: 0.3,
                    label: ref
                        .watch(providerGlobalNoiseOpacity)
                        .toStringAsFixed(3),
                    onChanged: (value) => ref
                        .read(providerGlobalNoiseOpacity.notifier)
                        .state = value,
                  ),
                  if (ref.watch(providerGlobalNoiseOpacity) != 0.03)
                    IconButton(
                      tooltip: 'Restore Default',
                      onPressed: () {
                        ref.read(providerGlobalNoiseOpacity.notifier).state =
                            0.03;
                      },
                      icon: const Icon(
                        Symbols.refresh,
                      ),
                    )
                ],
              ),
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Scale',
                children: [
                  if (ref.watch(providerGlobalNoiseScale) % 1 != 0)
                    TextSpan(
                      text: ' (filtered)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
            ),
            subtitle: SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Row(
                children: [
                  Slider(
                    value: ref.watch(providerGlobalNoiseScale),
                    min: 0.25,
                    max: 2,
                    divisions: 7,
                    label:
                        ref.watch(providerGlobalNoiseScale).toStringAsFixed(2),
                    onChanged: (value) => ref
                        .read(providerGlobalNoiseScale.notifier)
                        .state = value,
                  ),
                  if (ref.watch(providerGlobalNoiseScale) != 1)
                    IconButton(
                      tooltip: 'Restore Default',
                      onPressed: () {
                        ref.read(providerGlobalNoiseScale.notifier).state = 1;
                      },
                      icon: const Icon(
                        Symbols.refresh,
                      ),
                    )
                ],
              ),
            ),
          ),
          divide,
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              'Noise Box',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            title: const Text('Width'),
            subtitle: SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Row(
                children: [
                  Slider(
                    value: _width,
                    min: 1,
                    max: 1024,
                    label: _width.floor().toString(),
                    onChanged: (value) => setState(() => _width = value),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Height'),
            subtitle: SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Row(
                children: [
                  Slider(
                    value: _height,
                    min: 1,
                    max: 1024,
                    label: _height.floor().toString(),
                    onChanged: (value) => setState(() => _height = value),
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          Row(
            children: [
              Flexible(
                child: ContentBox(
                  child: SizedBox(
                    width: _width,
                    height: _height,
                    child: const NoiseBox(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
