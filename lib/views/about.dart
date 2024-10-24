import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
 [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
 // Reemplaza con la ruta de tu imagen
            ),
            Text(
              'Cristofer De La Mota Alberto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.phone),
                SizedBox(width: 10),
                Text('829-694-1107'),
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.envelope),
                SizedBox(width: 10),
                Text('cristoferdelamota0105@gmail.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}