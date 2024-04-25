import 'package:flutter/material.dart';

class TextEditDialog extends StatefulWidget {
  const TextEditDialog({
    this.defaultValue,
    this.title,
    this.nullable = false,
    this.multiline = false,
    this.maxLength,
    this.monospaced = false,
    super.key,
  });
  final String? defaultValue;
  final String? title;
  final bool nullable;
  final bool multiline;
  final int? maxLength;
  final bool monospaced;

  @override
  createState() => _TextEditDialogState();
}

class _TextEditDialogState extends State<TextEditDialog> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null || !widget.nullable) _createController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontFamily =
        'packages/pui/${widget.monospaced ? 'JetBrains Mono' : 'Albert Sans'}';

    return AlertDialog(
      title: Text(widget.title ??
          'Edit ${widget.multiline ? 'Multi-line ' : ''}${widget.nullable ? 'Nullable Text' : 'Text'}'),
      content: Row(
        children: [
          if (widget.nullable)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Switch(
                  value: _controller != null,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        _createController();
                      } else {
                        _controller?.dispose();
                        _controller = null;
                      }
                    });
                  }),
            ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 350,
                maxWidth: 700,
              ),
              child: TextField(
                controller: _controller,
                onChanged: (_) {
                  setState(() {});
                },
                enabled: _controller != null,
                autofocus: true,
                minLines: 1,
                maxLines: widget.multiline ? 16 : null,
                maxLength: widget.maxLength,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: _controller == null
                      ? 'Null'
                      : _controller!.text.isEmpty
                          ? 'Empty'
                          : null,
                  labelText: _controller == null
                      ? 'Null'
                      : _controller!.text.isEmpty
                          ? 'Empty'
                          : null,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(_controller?.text);
          },
          style: Theme.of(context).filledButtonTheme.style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  const Size(20, 40),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 14),
                ),
              ),
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void _createController() {
    _controller = TextEditingController(text: widget.defaultValue);
  }
}
