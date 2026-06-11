import 'package:flutter/material.dart';

class DetailGambar extends StatelessWidget {
  final String imageUrl;
  const DetailGambar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang hitam khas galeri foto
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: const Text(
          "Pratinjau Gambar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Hero(
          tag:
              'detail_foto_transaksi', // Menghubungkan animasi transisi dari halaman sebelumnya
          child: InteractiveViewer(
            panEnabled: true, // Mengizinkan gambar digeser saat di-zoom
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.5, // Batas zoom terkecil
            maxScale: 4.0, // Batas zoom terbesar (4x lipat)
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain, // Memastikan seluruh gambar muat di layar
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
