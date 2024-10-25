import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  String apiKey = 'abd3e00863dfe22a8c318fae22294e97'; // Reemplaza con tu API key
  String city = 'Santo Domingo';
  Map<String, dynamic> weatherData = {};
  bool isLoading = true;

  Future<void> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        // Manejar errores
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Manejar excepciones
      print('Error al obtener los datos del clima: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en $city'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ListView(
                children: [
                  // Sección de la ciudad y temperatura
                  Text(
                    weatherData['name'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${weatherData['main']['temp'].toStringAsFixed(1)} °C',
                    style: const TextStyle(fontSize: 32),
                  ),
                  SvgPicture.network(
                    'http://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}.png',
                    height: 100,
                    width: 100,
                  ),
                  // Sección de detalles adicionales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(FontAwesomeIcons.droplet),
                          Text('Humedad: ${weatherData['main']['humidity']}%'),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(FontAwesomeIcons.wind),
                          Text('Viento: ${weatherData['wind']['speed']} m/s'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}