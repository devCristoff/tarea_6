import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Icono de toolbox
            const Icon(
              FontAwesomeIcons.toolbox,
              size: 50,
            ),
            const SizedBox(height: 20),
            // Botones de navegación
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/genero');
              },
              child: const Text('Género'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edad');
              },
              child: const Text('Edad'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pais');
              },
              child: const Text('País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clima');
              },
              child: const Text('Clima'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/post');
              },
              child: const Text('Post'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/acerca');
              },
              child: const Text('Acerca'),
            ),
            // ... Agrega los demás botones de la misma manera
          ],
        ),
      ),
    );
  }
}