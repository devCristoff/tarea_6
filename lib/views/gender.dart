import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});
  
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final TextEditingController _nameController = TextEditingController();
  String gender = '';

  Future<void> getGender() async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=${_nameController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        gender = data['gender'];
      });
    } else {
      // Manejar error si la petición falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predecir Género'),
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
              onPressed: getGender,
              child: const Text('Predecir'),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              color: gender == 'male' ? Colors.blue : (gender == 'female' ? Colors.pink : Colors.grey),
              child: Center(
                child: Text(
                  gender == '' ? 'Ingrese un nombre para predecir' : 'Gender: $gender',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}