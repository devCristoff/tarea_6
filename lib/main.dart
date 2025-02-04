import 'package:flutter/material.dart';
import 'package:tarea_6/views/about.dart';
import 'package:tarea_6/views/weather.dart';
import 'package:tarea_6/views/age.dart';
import 'package:tarea_6/views/gender.dart';
import 'package:tarea_6/views/home.dart';
import 'package:tarea_6/views/country.dart';
import 'package:tarea_6/views/post.dart';

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
        '/gender': (context) => const GenderPage(),
        '/age': (context) => const AgePage(),
        '/country': (context) => const CountryPage(),
        '/weather': (context) => const WeatherPage(),
        '/post': (context) => const NewsPage(),
        '/about': (context) => const AboutPage(),
        // ... Agrega las rutas para las demás vistas
      },
    );
  }
}