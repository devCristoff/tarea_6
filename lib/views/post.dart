import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  List posts = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Función para obtener los últimos 3 posts
  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
          Uri.parse('https://www.unibe.edu.do/wp-json/wp/v2/posts?per_page=3'));

      if (response.statusCode == 200) {
        setState(() {
          posts = json.decode(response.body);
          errorMessage = ''; // Limpiar el mensaje de error
        });
      } else {
        setState(() {
          errorMessage = 'Error al cargar las noticias';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'No se pudo conectar al servidor';
      });
    }
  }

  // Función para abrir el link en el navegador
  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo oscuro
      appBar: AppBar(
        title: const Text('Noticias recientes'),
        backgroundColor: Colors.blueAccent, // Color del AppBar en azul
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchPosts,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mostrar el logo de la página web
            Container(
              alignment: Alignment.center,
              child: Image.asset('assets/images/unibe.png', height: 80),
            ),
            const SizedBox(height: 16),
            // Mostrar las noticias
            errorMessage.isNotEmpty
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )
                : posts.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            var post = posts[index];
                            return Card(
                              color: Colors.grey[850], // Fondo oscuro en la tarjeta
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['title']['rendered'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Limitar longitud del extracto
                                    Text(
                                      _truncateHtml(post['excerpt']['rendered'], 100),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          _launchURL(post['link']);
                                        },
                                        icon: const Icon(
                                          Icons.open_in_new,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          'Leer más',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 15,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  String _truncateHtml(String html, int length) {
    // Eliminar etiquetas HTML y limitar la longitud
    String plainText = html.replaceAll(RegExp(r'<[^>]*>'), '');
    return plainText.length > length ? '${plainText.substring(0, length)}...' : plainText;
  }
}
