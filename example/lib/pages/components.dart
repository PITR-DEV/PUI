import 'package:example/providers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pui/pui.dart';

class ComponentsPage extends ConsumerStatefulWidget {
  const ComponentsPage({super.key});

  @override
  createState() => _ComponentsPageState();
}

class _ComponentsPageState extends ConsumerState<ComponentsPage> {
  int _intValue = 0;
  double _doubleValue = 0.0;
  String _stringValue = 'Hello, World!';

  @override
  Widget build(BuildContext context) {
    const divide = Divider(
      height: 42,
      thickness: 1,
    );

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              'Components',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Gap(16),
          Text(
            'Buttons',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          Row(
            children: [
              FilledButton(
                child: const Text('Filled Button'),
                onPressed: () {},
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Filled Tonal Button'),
                onPressed: () {},
              ),
              const Gap(4),
              OutlinedButton(
                child: const Text('Outlined Button'),
                onPressed: () {},
              ),
              const Gap(4),
              TextButton(
                child: const Text('Text Button'),
                onPressed: () {},
              ),
            ],
          ),
          divide,
          Text(
            'Text Fields',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          const Row(
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: 'TextField',
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          const Row(
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: 'Dense TextField',
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          divide,
          Text(
            'Indicators',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          const Row(
            children: [
              ContentBox(
                child: Row(
                  children: [
                    Text('Spinner'),
                    Gap(12),
                    Spinner(),
                  ],
                ),
              ),
              ContentBox(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text('Spinner (32px)'),
                    Gap(12),
                    Spinner(
                      size: 32,
                    ),
                  ],
                ),
              ),
              ContentBox(
                child: Row(
                  children: [
                    Text('Ticker'),
                    Gap(12),
                    Ticker(),
                  ],
                ),
              )
            ],
          ),
          divide,
          Text(
            'Content Boxes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          const Row(
            children: [
              ContentBox(
                child: Text('Content Box'),
              ),
              Gap(4),
              ContentBox(
                elevation: 4,
                child: Text('Content Box with Elevation'),
              ),
            ],
          ),
          const Row(
            children: [
              ContentBox(
                elevation: -1,
                child: Text('Negative Content Box'),
              ),
              Gap(4),
              ContentBox(
                elevation: -4,
                child: Text('Negative Content Box with Elevation'),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              SizedBox(
                width: 270,
                child: ContentBox(
                  elevation: ref.watch(providerContentBoxElevation),
                  child: ListTile(
                    title: const Text('Elevation'),
                    dense: true,
                    subtitle: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Slider(
                            value: ref.watch(providerContentBoxElevation),
                            min: -5,
                            max: 5,
                            divisions: 10,
                            label: ref
                                .watch(providerContentBoxElevation)
                                .floor()
                                .toString(),
                            onChanged: (value) => ref
                                .read(providerContentBoxElevation.notifier)
                                .state = value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          divide,
          Text(
            'Variable Editors',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(8),
                    Text(
                      'Integer',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(4),
                    VariableEditor(
                      value: _intValue,
                      onChanged: (num value) => setState(() {
                        _intValue = value.toInt();
                      }),
                    ),
                    const Gap(8),
                    Text.rich(
                      TextSpan(text: 'Float', children: [
                        TextSpan(
                          text: ' (double)',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceTint
                                .withOpacity(0.4),
                          ),
                        ),
                      ]),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(4),
                    VariableEditor(
                      value: _doubleValue,
                      onChanged: (num value) => setState(() {
                        _doubleValue = value.toDouble();
                      }),
                    ),
                    const Gap(8),
                    Text(
                      'String',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(4),
                    VariableEditor(
                        value: _stringValue,
                        onChanged: (value) {
                          setState(() {
                            _stringValue = value;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
