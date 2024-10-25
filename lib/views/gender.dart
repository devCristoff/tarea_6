import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  GenderPageState createState() => GenderPageState();
}

class GenderPageState extends State<GenderPage> {
  final TextEditingController _nameController = TextEditingController();
  String gender = '';
  bool isLoading = false;

  Future<void> getGender() async {
    setState(() {
      isLoading = true; // Mostrar indicador de carga
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=${_nameController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        gender = data['gender'];
      });
    } else {
      // Manejar error si la petición falla
    }

    setState(() {
      isLoading = false; // Ocultar indicador de carga
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo oscuro
      appBar: AppBar(
        title: const Text('Predecir Género'),
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

              // Botón de predicción con ícono
              ElevatedButton.icon(
                onPressed: getGender,
                icon: const Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
                label: const Text('Predecir', style: TextStyle(color: Colors.white)),
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
                // Contenedor para mostrar el resultado del género
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: gender == 'male'
                        ? Colors.blue
                        : (gender == 'female' ? Colors.pink : Colors.grey[800]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      gender == ''
                          ? 'Ingrese un nombre para predecir'
                          : 'Predicción de género: $gender',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
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
