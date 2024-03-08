import 'package:flutter/material.dart';

import 'areas/home/screens/screens.dart';

class CalculatePathApp extends StatelessWidget {
  const CalculatePathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
