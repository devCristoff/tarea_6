import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Fondo oscuro para mantener la coherencia
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: Colors.blueAccent, // Color del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar redondo con imagen de perfil
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'assets/images/profile.jpg'), // Reemplaza con la ruta de tu imagen
              ),
              const SizedBox(height: 20),

              // Nombre del usuario
              const Text(
                'Cristofer De La Mota Alberto',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto blanco
                ),
              ),
              const SizedBox(height: 5),

              // Línea divisoria estilizada
              const Divider(
                thickness: 2,
                color: Colors.blueAccent, // Línea en color temático azul
                indent: 50,
                endIndent: 50,
              ),
              const SizedBox(height: 20),

              // Información de contacto
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.phone, color: Colors.white70),
                      SizedBox(width: 10),
                      Text(
                        '829-694-1107',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.envelope, color: Colors.white70),
                      SizedBox(width: 10),
                      Text(
                        'cristoferdelamota0105@gmail.com',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Redes sociales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.linkedin,
                            color: Colors.white),
                        onPressed: () async {
                          const url =
                              'https://www.linkedin.com/in/cristofer-de-la-mota-alberto/';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            // Handle the case when the URL cannot be launched
                            print('Could not launch $url');
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.github,
                            color: Colors.white),
                        onPressed: () async {
                          const url =
                              'https://github.com/devCristoff';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            // Handle the case when the URL cannot be launched
                            print('Could not launch $url');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Botón de "Conectar" para hacer más interactiva la pantalla
              ElevatedButton.icon(
                onPressed: () async {
                  const url =
                      'mailto:cristoferdelamota0105@gmail.com';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    // Handle the case when the URL cannot be launched
                    print('Could not launch $url');
                  }
                },
                icon: const Icon(FontAwesomeIcons.userPlus,
                    color: Colors.black87),
                label: const Text(
                  'Conectar',
                  style: TextStyle(color: Colors.black87),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Color del botón
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
