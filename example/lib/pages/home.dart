import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            'Welcome to the PUI example gallery.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(21),
          Text(
            'PUI Links',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(6),
          Row(
            children: [
              TextButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://link.pitr.dev/pui_github')),
                child: const Text('GitHub'),
              ),
              const Gap(6),
              TextButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://link.pitr.dev/pui_dart')),
                child: const Text('pub.dev'),
              ),
              const Gap(6),
              TextButton(
                onPressed: () => launchUrl(Uri.parse('https://pui.pitr.dev')),
                child: Text.rich(
                  TextSpan(
                    text: 'Gallery Example',
                    children: [
                      TextSpan(
                        text: ' (you\'re here)',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
