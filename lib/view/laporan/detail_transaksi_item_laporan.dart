import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintakqu/view/laporan/detail_gambar.dart';

class DetailTransaksiItemLaporan extends StatefulWidget {
  const DetailTransaksiItemLaporan({super.key});

  @override
  State<DetailTransaksiItemLaporan> createState() =>
      _DetailTransaksiItemLaporanState();
}

class _DetailTransaksiItemLaporanState
    extends State<DetailTransaksiItemLaporan> {
  String? _gambarPath;

  // Fungsi bantuan agar tidak perlu menulis Navigator.push berulang-ulang
  void _bukaGambarPenuh(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const DetailGambar(imageUrl: 'https://picsum.photos'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Item Transaksi",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  const Text(
                    "NOMINAL TRANSAKSI",
                    style: TextStyle(
                      color: Color(0xFF44474E),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Rp 420.000",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 130,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDAD6),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 12,
                            top: 5,
                            bottom: 5,
                            right: 8,
                          ),
                          child: Icon(
                            Icons.south,
                            color: Color(0XFF93000A),
                            size: 14,
                          ),
                        ),
                        Text(
                          "Pengeluaran",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF93000A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                  color: const Color(0XFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tanggal Transaksi",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF44474E),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.date_range_outlined),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "12 Juni 2026 , 14:03",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF181C1E),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 16),
                      Text(
                        "Kategori",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF44474E),
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFFFDAD6),
                            child: Icon(
                              Icons.health_and_safety,
                              color: Color(0xFF93000A),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Kesehatan",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 16),
                      Text(
                        "Keterangan/Catatan",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF44474E),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Id proident magna sunt et do in qui ex laboris velit ut deserunt. Enim ea sit est ex. In aliqua velit veniam labore laboris nostrud irure voluptate ex.",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Bagian Struk Transaksi & Tombol Lihat Penuh
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Struk Transaksi",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0XFF181C1E),
                        ),
                      ),
                      const Spacer(),

                      // TRIGGER 1: Tulisan "Lihat Penuh" dibungkus GestureDetector
                      GestureDetector(
                        onTap: () => _bukaGambarPenuh(context),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fullscreen,
                              size: 18,
                              color: Color(0XFF0050CC),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Lihat Penuh",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF0050CC),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => _bukaGambarPenuh(context),
                    child: Hero(
                      tag: 'detail_foto_transaksi',
                      child: Container(
                        width: 380,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E3E6)),

                          // 2. UBAH DI BAGIAN INI
                          image: _gambarPath != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(_gambarPath!),
                                  ), // Membaca file dari path image_picker
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  // Gambar cadangan (placeholder) jika belum ada foto yang diambil
                                  image: AssetImage(
                                    'assets/images/placeholder.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
