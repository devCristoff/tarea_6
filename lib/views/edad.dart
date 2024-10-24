import 'package:flutter/material.dart';

class EdadPage extends StatelessWidget {
  const EdadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edad'),
      ),
      body: const Center(
        child: Text('Edad'),
      ),
    );
  }
}
