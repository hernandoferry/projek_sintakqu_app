import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart';
import 'package:projek_sintakqu_app/login.dart';
import 'package:projek_sintakqu_app/view/home/index_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SintakQu',
      home: FutureBuilder<bool>(
        future: DbHelper().cekStatusLogin(), // Memanggil fungsi auto-redirect
        builder: (context, snapshot) {
          // Menampilkan loading screen saat database sedang memeriksa status
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Jika hasil pemeriksaan bernilai true, langsung buka IndexHome
          if (snapshot.hasData && snapshot.data == true) {
            return const IndexHome();
          }

          // Jika false atau belum pernah login, arahkan ke halaman Login biasa
          return const Login();
        },
      ),
    );
  }
}
