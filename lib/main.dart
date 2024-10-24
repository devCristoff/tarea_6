import 'package:flutter/material.dart';
import 'package:tarea_6/views/acerca.dart';
import 'package:tarea_6/views/clima.dart';
import 'package:tarea_6/views/edad.dart';
import 'package:tarea_6/views/gender.dart';
import 'package:tarea_6/views/home.dart';
import 'package:tarea_6/views/pais.dart';
import 'package:tarea_6/views/post.dart';
// ... Importaciones de las demás vistas

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Multifuncional',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/genero': (context) => const GenderPage(),
        '/edad': (context) => const EdadPage(),
        '/pais': (context) => const PaisPage(),
        '/clima': (context) => const ClimaPage(),
        '/post': (context) => const PostPage(),
        '/acerca': (context) => const AcercaPage(),
        // ... Agrega las rutas para las demás vistas
      },
    );
  }
}