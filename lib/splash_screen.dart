import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 811,
            width: 375,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 227, 242, 253),
                  Color.fromARGB(255, 187, 222, 251),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset(
                    "assets/images/splash_image.png",
                    width: 220,
                    height: 220,
                  ),
                  Text(
                    'SintakQu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF181C1E),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sistem Informasi Catatan Keuangan Keluarga Qu',
                    style: TextStyle(fontSize: 14, color: Color(0xFF44474E)),
                  ),
                  Spacer(),
                  Text(
                    'Versi : 1.0.0',
                    style: TextStyle(color: Color(0xFFC5C6CF)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
