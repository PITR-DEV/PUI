import 'package:flutter/material.dart';

class HiddenPage extends StatefulWidget {
  const HiddenPage({super.key});

  @override
  State<HiddenPage> createState() => _HiddenPageState();
}

class _HiddenPageState extends State<HiddenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidden Page'),
      ),
      body: const Center(
        child: Text('Boo!, you found me!'),
      ),
    );
  }
}
