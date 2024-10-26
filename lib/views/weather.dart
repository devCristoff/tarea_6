import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
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
  String errorMessage = '';

  Future<void> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          isLoading = false;
          errorMessage = ''; // Limpiar mensaje de error
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Error al obtener datos: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error al obtener los datos del clima: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'No se pudo conectar al servidor';
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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Clima en $city'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.blueAccent)
            : errorMessage.isNotEmpty
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              weatherData['name'],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${weatherData['main']['temp'].toStringAsFixed(1)} °C',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SvgPicture.network(
                              'http://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}.svg',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              weatherData['weather'][0]['description']
                                  .toString()
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Divider(
                              color: Colors.blueGrey[300],
                              thickness: 1,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(FontAwesomeIcons.droplet,
                                        size: 30, color: Colors.blueAccent),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Humedad',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${weatherData['main']['humidity']}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(FontAwesomeIcons.wind,
                                        size: 30, color: Colors.blueAccent),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Viento',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${weatherData['wind']['speed']} m/s',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(FontAwesomeIcons.thermometerHalf,
                                        size: 30, color: Colors.blueAccent),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sensación',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${weatherData['main']['feels_like'].toStringAsFixed(1)} °C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
