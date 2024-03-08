import 'package:example/providers/noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
              'Noise',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Gap(16),
          Text(
            'Global Noise Overlay',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ListTile(
            leading: Switch(
              value: ref.watch(providerGlobalNoiseEnabled),
              onChanged: (value) {
                ref.read(providerGlobalNoiseEnabled.notifier).state = value;
              },
            ),
          ),
          divide,
          Text(
            'Noise Box (inside of content box)',
            style: Theme.of(context).textTheme.headlineSmall,
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
