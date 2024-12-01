import 'package:flutter/material.dart';

import 'image_converter_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(const ImageConverterApp());
}

class ImageConverterApp extends StatelessWidget {
  const ImageConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green[900],
        scaffoldBackgroundColor: Colors.green[900],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => ImageConverterPage(), // Sua tela principal
      },
    );
  }
}
