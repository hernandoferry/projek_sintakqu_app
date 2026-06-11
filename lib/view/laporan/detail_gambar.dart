import 'dart:io';

import 'package:flutter/material.dart';

class DetailGambar extends StatelessWidget {
  final String imageUrl;

  const DetailGambar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final file = File(imageUrl);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Pratinjau Gambar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'detail_foto_transaksi',
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20),
            child: file.existsSync()
                ? Image.file(file, fit: BoxFit.contain)
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, color: Colors.white, size: 80),
                      SizedBox(height: 12),
                      Text(
                        'Gambar tidak ditemukan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
