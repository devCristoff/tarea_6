import 'package:flutter/material.dart';

class PaisPage extends StatelessWidget {
  const PaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pais'),
      ),
      body: const Center(
        child: Text('Pais'),
      ),
    );
  }
}
