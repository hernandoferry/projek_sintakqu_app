import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:sintakqu/database/db_helper.dart';
import 'package:sintakqu/firebase_options.dart';
import 'package:sintakqu/login.dart';
import 'package:sintakqu/splash_screen.dart';
import 'package:sintakqu/theme/app_theme.dart';
import 'package:sintakqu/theme/theme_controller.dart';
import 'package:sintakqu/view/home/index_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ThemeController.instance.loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _inisialisasiAplikasi() async {
    // Splash minimal 4 detik
    await Future.delayed(const Duration(seconds: 3));

    // Cek session Firebase
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'SintakQu',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          themeMode: mode, // Menghilangkan banner debug opsional
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
      },
    );
  }
}
