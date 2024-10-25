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

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Función para obtener los últimos 3 posts
  Future<void> fetchPosts() async {
    final response = await http.get(
        Uri.parse('https://www.unibe.edu.do/wp-json/wp/v2/posts?per_page=3'));

    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar las noticias');
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
      appBar: AppBar(
        title: const Text('Noticias recientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mostrar el logo de la página web
            Image.asset('assets/images/unibe.png'),
            const SizedBox(height: 16),
            // Mostrar las noticias
            posts.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        var post = posts[index];
                        return Card(
                          elevation: 5,
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
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post['excerpt']['rendered'].replaceAll(
                                      RegExp(r'<[^>]*>'),
                                      ''), // Eliminar etiquetas HTML
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    _launchURL(post['link']);
                                  },
                                  child: const Text('Visitar'),
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
}
