import 'package:flutter/material.dart';
import 'Screens/login_page.dart';
import 'Screens/page_home.dart';
import 'Screens/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // supprime le bandeau DEBUG
      initialRoute: '/', // page de démarrage
      routes: {
        '/': (context) => PageHome(),
        '/login': (context) => PageLogin(), // page d'accueil
        '/register': (context) => const PageRegister(),
      },
    );
  }
}
