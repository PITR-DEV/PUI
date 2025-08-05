import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BoolEditor extends StatelessWidget {
  const BoolEditor({required this.value, this.onChanged, super.key});
  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Transform.scale(
          scale: 0.85,
          child: Switch(
            value: value,
            onChanged: onChanged as ValueChanged<bool>?,
          ),
        ),
        const Gap(4),
        Text(
          value.toString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color:
                value ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
