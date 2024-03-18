import 'package:example/providers/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pui/pui.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
              'Home',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Gap(16),
          Text(
            'Controls',
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
            'Dialogs',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          Row(
            children: [
              FilledButton(
                child: const Text('Show Alert Dialog'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Alert Dialog'),
                      content: const Text('This is an alert dialog.'),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
                child: SelectableText('Negative Content Box'),
              ),
              Gap(4),
              ContentBox(
                elevation: -4,
                child: SelectableText('Negative Content Box with Elevation'),
              ),
            ],
          ),
          const Gap(8),
          ListTile(
            title: const Text('Elevation'),
            subtitle: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Row(
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
          Row(
            children: [
              ContentBox(
                elevation: ref.watch(providerContentBoxElevation),
                child: SelectableText(
                    'Content Box with (${ref.watch(providerContentBoxElevation).floor()}) elevation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
