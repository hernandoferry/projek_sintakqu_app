import 'package:flutter/material.dart';
import 'package:sintakqu/database/db_helper.dart';
import 'package:sintakqu/login.dart';
import 'package:sintakqu/splash_screen.dart';
import 'package:sintakqu/view/home/index_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Fungsi inisialisasi untuk memastikan SplashScreen berdurasi minimal 2 detik
  Future<bool> _inisialisasiAplikasi() async {
    final hasilCekLogin = DbHelper().cekStatusLogin();
    final jedaWaktu = Future.delayed(const Duration(seconds: 2));
    final hasil = await Future.wait([hasilCekLogin, jedaWaktu]);

    // Kembalikan hasil status login (elemen pertama dari hasil Future.wait)
    return hasil[0] as bool;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SintakQu',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug opsional
      home: FutureBuilder<bool>(
        future: _inisialisasiAplikasi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          // Jika data berhasil diambil dan status login bernilai true
          if (snapshot.hasData && snapshot.data == true) {
            return const IndexHome();
          }

          // Jika belum login atau terjadi error, arahkan ke Login screen
          return const Login();
        },
      ),
    );
  }
}
