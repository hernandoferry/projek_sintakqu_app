import 'package:flutter/material.dart';
// import 'package:projek_sintakqu_app/splash_screen.dart';
import 'package:projek_sintakqu_app/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SintakQu',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      // home: SplashScreen(),
      home: Login(),
      // home: Register(),
    );
  }
}
