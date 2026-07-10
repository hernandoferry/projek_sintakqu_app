import 'package:flutter/material.dart';
import 'package:sintakqu/theme/theme_controller.dart';

class TemaAplikasi extends StatefulWidget {
  const TemaAplikasi({super.key});

  @override
  _TemaAplikasiState createState() => _TemaAplikasiState();
}

class _TemaAplikasiState extends State<TemaAplikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Tema'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x1A0050CC), height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: const Text("Light Mode"),
                onTap: () {
                  ThemeController.instance.setTheme(ThemeMode.light);
                },
              ),

              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                onTap: () {
                  ThemeController.instance.setTheme(ThemeMode.dark);
                },
              ),

              ListTile(
                leading: const Icon(Icons.phone_android),
                title: const Text("Ikuti Sistem"),
                onTap: () {
                  ThemeController.instance.setTheme(ThemeMode.system);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
