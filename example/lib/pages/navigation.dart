import 'package:example/providers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({super.key});

  @override
  createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage> {
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
              'Navigation',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Gap(16),
          Text(
            'App Bar',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          ListTile(
            leading: Switch(
              value: ref.watch(providerShowAppBar),
              onChanged: (value) {
                ref.read(providerShowAppBar.notifier).state = value;
              },
            ),
          ),
          divide,
          Text(
            'Bottom Bar',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          ListTile(
            leading: Switch(
              value: ref.watch(providerShowBottomBar),
              onChanged: (value) {
                ref.read(providerShowBottomBar.notifier).state = value;
              },
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
                    value: ref.watch(providerBottomBarHeight),
                    min: 0,
                    max: 256,
                    label:
                        ref.watch(providerBottomBarHeight).floor().toString(),
                    onChanged: (value) => ref
                        .read(providerBottomBarHeight.notifier)
                        .state = value,
                  ),
                ],
              ),
            ),
          ),
          divide,
          Text(
            'Tabs',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          Row(
            children: [
              FilledButton.tonal(
                child: const Text('Open Hidden Page'),
                onPressed: () {
                  context.go('/hidden');
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Open 404 Page'),
                onPressed: () {
                  context.go('/404');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
