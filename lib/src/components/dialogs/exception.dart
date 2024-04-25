import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ExceptionDialog extends StatelessWidget {
  const ExceptionDialog(
      {required this.exception, this.title = 'Exception!', super.key});
  final Object? exception;
  final String title;

  static Future<void> show(BuildContext context, Object? exception) {
    return showDialog(
      context: context,
      builder: (context) => ExceptionDialog(exception: exception),
      barrierColor:
          Color.lerp(Colors.black, Colors.red, 0.05)!.withOpacity(0.9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _getThemeData(context),
      child: AlertDialog(
        title: Text(title),
        icon: const Icon(Symbols.error),
        scrollable: true,
        content: Column(
          children: buildContent(),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  List<Widget> buildContent() {
    final content = <Widget>[];

    if (exception != null) {
      content.add(SelectableText('Exception: $exception'));
    }

    return content;
  }

  ThemeData _getThemeData(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red, brightness: theme.brightness),
    );
  }
}
