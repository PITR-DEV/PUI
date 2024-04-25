import 'package:flutter/material.dart';
import 'package:pui/src/components/variable_editor/num_editor.dart';
import 'package:pui/src/components/variable_editor/string_editor.dart';

class VariableEditor<T> extends StatelessWidget {
  const VariableEditor({required this.value, this.onChanged, super.key});

  final T value;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (value is String) {
      return StringEditor(
          value: value as String,
          onChanged: onChanged as ValueChanged<String>?);
    }
    if (value is num) {
      return NumEditor(
          value: value as num, onChanged: onChanged as ValueChanged<num>?);
    }

    return fallback();
  }

  Widget fallback() {
    return Text(
      value.toString(),
      style: const TextStyle(
        fontFamily: 'packages/pui/Albert Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
