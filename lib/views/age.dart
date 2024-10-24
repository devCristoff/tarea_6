import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final TextEditingController _nameController = TextEditingController();
  int age = 0;

  Future<void> getAge() async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=${_nameController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        age = data['age'];
      });
    } else {
      // Manejar error si la petición falla
    }
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
      appBar: AppBar(
        title: const Text('Estimar Edad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ingrese un nombre',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getAge,
              child: const Text('Estimar'),
            ),
            const SizedBox(height: 20),
            Text('Edad estimada: $age'),
            Text(getAgeCategory(age)),
            // Aquí puedes agregar la lógica para mostrar la imagen correspondiente
            // Puedes utilizar un Image.asset o un Image.network
            // Ejemplo con Image.asset:
            Image.asset(
              'assets/images/${getAgeCategory(age)}.png',
              width: 200,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}