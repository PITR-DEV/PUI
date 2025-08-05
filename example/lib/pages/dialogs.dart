import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pui/pui.dart';

class DialogsPage extends ConsumerStatefulWidget {
  const DialogsPage({super.key});

  @override
  createState() => _DialogsPageState();
}

class _DialogsPageState extends ConsumerState<DialogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              'Dialogs',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Gap(16),
          Text(
            'Generic',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          Row(
            children: [
              FilledButton(
                child: const Text('Show Generic Dialog'),
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
          const Gap(16),
          Text(
            'TextEditDialog',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          Row(
            children: [
              FilledButton.tonal(
                child: const Text('Show'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const TextEditDialog(
                      defaultValue: 'Default Value',
                    ),
                  );
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Show (Nullable)'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const TextEditDialog(
                      nullable: true,
                    ),
                  );
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Show Multi-line'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const TextEditDialog(
                      multiline: true,
                    ),
                  );
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Show Multi-line (Nullable)'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const TextEditDialog(
                      nullable: true,
                      multiline: true,
                      defaultValue: 'Default Value.\nHi! 😭',
                    ),
                  );
                },
              ),
            ],
          ),
          const Gap(16),
          Text(
            'ListEditDialog',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(8),
          Row(
            children: [
              FilledButton.tonal(
                child: const Text('Show String List'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ListEditDialog<String>(
                      defaultValue: [
                        'Default List Item 1',
                        'Default List Item 2'
                      ],
                      defaultItemValue: 'Default New Item',
                    ),
                  );
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Show Int List'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ListEditDialog<int>(
                      defaultValue: [
                        1,
                        200,
                        2938475,
                      ],
                      defaultItemValue: 0,
                    ),
                  );
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Show Double List'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ListEditDialog<double>(
                      defaultValue: [
                        1.0,
                        1.5,
                        pi,
                      ],
                      defaultItemValue: 0,
                    ),
                  );
                },
              ),
              const Gap(4),
              FilledButton.tonal(
                child: const Text('Show Boolean List'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ListEditDialog<bool>(
                      defaultValue: [
                        false,
                        false,
                        true,
                      ],
                      defaultItemValue: false,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
