import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  CountryPageState createState() => CountryPageState();
}

class CountryPageState extends State<CountryPage> {
  final TextEditingController _countryController = TextEditingController();
  List<dynamic> universidades = [];

  Future<void> buscarUniversidades() async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=${_countryController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        universidades = data;
      });
    } else {
      // Manejar error si la petición falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Universidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Ingrese el nombre del país (en inglés)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: buscarUniversidades,
              child: const Text('Buscar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: universidades.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(universidades[index]['name']),
                    subtitle: Text(universidades[index]['web_pages'][0]),
                    onTap: () {
                      // Aquí puedes agregar la lógica para abrir el enlace de la universidad en un navegador
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}