import 'package:flutter/material.dart';
import 'package:pui/src/components/variable_editor/bool_editor.dart';
import 'package:pui/src/components/variable_editor/num_editor.dart';
import 'package:pui/src/components/variable_editor/string_editor.dart';

class VariableEditor<T> extends StatelessWidget {
  const VariableEditor({required this.value, this.onChanged, super.key});

  final T value;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (T == String) {
      return StringEditor(
          value: value as String,
          onChanged: onChanged as ValueChanged<String>?);
    }
    if (T == int) {
      return NumEditor<int>(
          value: value as int, onChanged: onChanged as ValueChanged<int>?);
    }
    if (T == double) {
      return NumEditor<double>(
          value: value as double,
          onChanged: onChanged as ValueChanged<double>?);
    }
    if (T == bool) {
      return BoolEditor(
          value: value as bool, onChanged: onChanged as ValueChanged<bool>?);
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
