import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo oscuro para el estilo de herramientas
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza los elementos verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
          children: [
            // Icono de toolbox con título
            const Icon(
              FontAwesomeIcons.toolbox,
              size: 100,
              color: Colors.blueAccent, // Colores vibrantes para resaltar
            ),
            const SizedBox(height: 20),
            const Text(
              'Herramientas',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white, // Texto en blanco para buen contraste
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Botones de navegación con estilo mejorado
            _buildToolButton(
              context,
              icon: FontAwesomeIcons.venusMars, // Ícono representativo
              label: 'Género',
              routeName: '/gender',
            ),
            const SizedBox(height: 20),
            _buildToolButton(
              context,
              icon: FontAwesomeIcons.cakeCandles, // Ícono para edad
              label: 'Edad',
              routeName: '/age',
            ),
            const SizedBox(height: 20),
            _buildToolButton(
              context,
              icon: FontAwesomeIcons.globe, // Ícono para país
              label: 'País',
              routeName: '/country',
            ),
            const SizedBox(height: 20),
            _buildToolButton(
              context,
              icon: FontAwesomeIcons.cloudSunRain, // Ícono para clima
              label: 'Clima',
              routeName: '/weather',
            ),
            const SizedBox(height: 20),
            _buildToolButton(
              context,
              icon: FontAwesomeIcons.pen, // Ícono para post
              label: 'Post',
              routeName: '/post',
            ),
            const SizedBox(height: 20),
            _buildToolButton(
              context,
              icon: FontAwesomeIcons.circleInfo, // Ícono para acerca
              label: 'Acerca',
              routeName: '/about',
            ),
          ],
        ),
      ),
    );
  }

  // Función que construye cada botón con su icono y ruta correspondiente
  Widget _buildToolButton(BuildContext context, {required IconData icon, required String label, required String routeName}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        backgroundColor: Colors.blueAccent, // Color de los botones
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        shadowColor: Colors.blueAccent.withOpacity(0.5), // Sombra
        elevation: 10, // Elevación para darle un efecto "flotante"
      ),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
