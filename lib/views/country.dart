import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  CountryPageState createState() => CountryPageState();
}

class CountryPageState extends State<CountryPage> {
  final TextEditingController _countryController = TextEditingController();
  List<dynamic> universidades = [];
  bool isLoading = false;

  Future<void> buscarUniversidades() async {
    setState(() {
      isLoading = true; // Mostrar indicador de carga
    });

    final response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=${_countryController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        universidades = data;
      });
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
        title: const Text('Buscar Universidades'),
        backgroundColor: Colors.blueAccent, // Color AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Centraliza los elementos verticalmente
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centraliza horizontalmente
          children: [
            // Campo de texto para ingresar el país
            TextField(
              controller: _countryController,
              style: const TextStyle(color: Colors.white), // Texto blanco
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre del país (en inglés)',
                labelStyle: const TextStyle(
                    color: Colors.white70), // Etiqueta con tono gris claro
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.flag,
                    color: Colors.white70), // Icono de bandera
              ),
            ),
            const SizedBox(height: 20),
            // Botón de búsqueda con ícono
            ElevatedButton.icon(
              onPressed: buscarUniversidades,
              icon: const Icon(FontAwesomeIcons.search, color: Colors.white),
              label:
                  const Text('Buscar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                backgroundColor: Colors.blueAccent, // Color del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
                elevation: 5, // Elevación del botón
              ),
            ),
            const SizedBox(height: 20),

            // Indicador de carga si está buscando
            if (isLoading)
              const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent))
            else
              Expanded(
                child: universidades.isNotEmpty
                    ? ListView.builder(
                        itemCount: universidades.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.grey[800], // Fondo de las tarjetas
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(
                                universidades[index]['name'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                universidades[index]['web_pages'][0],
                                style:
                                    const TextStyle(color: Colors.blueAccent),
                              ),
                              trailing: const Icon(
                                FontAwesomeIcons.globe,
                                color: Colors.white70,
                              ),
                              onTap: () {
                                // Agregar lógica para abrir el enlace en un navegador
                              },
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No se encontraron universidades.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
