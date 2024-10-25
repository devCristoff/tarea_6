import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  AgePageState createState() => AgePageState();
}

class AgePageState extends State<AgePage> {
  final TextEditingController _nameController = TextEditingController();
  int age = 0;
  bool isLoading = false;

  Future<void> getAge() async {
    setState(() {
      isLoading = true; // Mostrar indicador de carga
    });

    final response = await http.get(Uri.parse('https://api.agify.io/?name=${_nameController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        age = data['age'];
      });
    } else {
      // Manejar error si la petición falla
    }

    setState(() {
      isLoading = false; // Ocultar indicador de carga
    });
  }

  String getAgeCategory(int age) {
    if (age < 30) {
      return 'joven';
    } else if (age < 60) {
      return 'adulto';
    } else {
      return 'anciano';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo oscuro
      appBar: AppBar(
        title: const Text('Estimar Edad'),
        backgroundColor: Colors.blueAccent, // Color del AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Campo de texto para ingresar el nombre
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white), // Texto blanco
                decoration: InputDecoration(
                  labelText: 'Ingrese un nombre',
                  labelStyle: const TextStyle(color: Colors.white70), // Texto de la etiqueta
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.white70), // Icono de persona
                ),
              ),
              const SizedBox(height: 20),

              // Botón para estimar la edad con ícono
              ElevatedButton.icon(
                onPressed: getAge,
                icon: const Icon(FontAwesomeIcons.search, color: Colors.white),
                label: const Text('Estimar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  backgroundColor: Colors.blueAccent, // Color del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5, // Elevación del botón
                ),
              ),
              const SizedBox(height: 20),

              // Indicador de carga
              if (isLoading)
                const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
              else
                // Mostrar edad estimada
                Column(
                  children: [
                    Text(
                      age == 0 ? 'Edad estimada' : 'Edad estimada: $age',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(height: 10),

                    // Mostrar categoría de edad y la imagen asociada
                    Text(
                      getAgeCategory(age),
                      style: const TextStyle(fontSize: 22, color: Colors.white70),
                    ),
                    const SizedBox(height: 20),

                    // Imagen relacionada a la categoría de edad
                    if (age > 0)
                      Image.asset(
                        'assets/images/${getAgeCategory(age)}.png',
                        width: 200,
                        height: 300,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
