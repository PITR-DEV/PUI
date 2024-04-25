import 'package:flutter/material.dart';

class StringEditor extends StatefulWidget {
  const StringEditor({required this.value, this.onChanged, super.key});
  final String value;
  final Function(String)? onChanged;

  @override
  createState() => _StringEditorState();
}

class _StringEditorState extends State<StringEditor> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }

    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
      readOnly: widget.onChanged == null,
      onChanged: widget.onChanged == null
          ? null
          : (value) {
              widget.onChanged!(value);
            },
    );
  }
}
