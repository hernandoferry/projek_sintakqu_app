import 'package:flutter/material.dart';
// import 'package:sintakqu/database/db_helper.dart';
// import 'package:sintakqu/login.dart';
// import 'package:sintakqu/view/home/index_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 1,
              width: 420,
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
                      "assets/images/icon_dompet.png",
                      width: 330,
                      height: 330,
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
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 14.0),
                      child: Text(
                        'Versi : Beta',
                        style: TextStyle(color: Color(0xFF44474E)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
