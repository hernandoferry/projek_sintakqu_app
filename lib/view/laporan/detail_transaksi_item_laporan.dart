import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sintakqu/database/db_helper.dart';
import 'package:sintakqu/view/laporan/detail_gambar.dart';

class DetailTransaksiItemLaporan extends StatefulWidget {
  final int transaksiId;

  const DetailTransaksiItemLaporan({super.key, required this.transaksiId});

  @override
  State<DetailTransaksiItemLaporan> createState() =>
      _DetailTransaksiItemLaporanState();
}

class _DetailTransaksiItemLaporanState
    extends State<DetailTransaksiItemLaporan> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
  }

  void _bukaGambarPenuh(BuildContext context, String? pathGambar) {
    if (pathGambar != null && pathGambar.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailGambar(imageUrl: pathGambar),
        ),
      );
    }
  }

  String _formatRupiah(double nilai) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatCurrency.format(nilai);
  }

  String _formatTanggal(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
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
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE0E3E6)),
        ),
      ),
      body: FutureBuilder(
        future: DbHelper().getTransaksiById(widget.transaksiId),
        builder: (context, snapshot) {
          /// Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Terjadi kesalahan:\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          /// Data kosong
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                "Data transaksi tidak ditemukan",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            );
          }

          final transaksi = snapshot.data!;

          final String? fotoPath = transaksi.fotoStruk;

          final bool fotoAda =
              fotoPath != null &&
              fotoPath.isNotEmpty &&
              File(fotoPath).existsSync();

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),

                /// NOMINAL
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

                      Text(
                        _formatRupiah(transaksi.nilaiTransaksi),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFDAD6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.south,
                              size: 14,
                              color: const Color(0XFF93000A),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Pengeluaran",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0XFF93000A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// DETAIL TRANSAKSI
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const SizedBox(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
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

                          const SizedBox(height: 4),

                          Text(
                            _formatTanggal(transaksi.createdAt),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const Divider(),

                          const SizedBox(height: 16),

                          const Text(
                            "Kategori",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF44474E),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xFFFFDAD6),
                                child: Icon(
                                  Icons.health_and_safety,
                                  color: Color(0xFF93000A),
                                ),
                              ),

                              const SizedBox(width: 8),

                              Text(
                                transaksi.kategoriTrans,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          const Divider(),

                          const SizedBox(height: 16),

                          const Text(
                            "Keterangan/Catatan",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF44474E),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            transaksi.keterangan.isNotEmpty
                                ? transaksi.keterangan
                                : "Tidak ada catatan untuk transaksi ini",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// FOTO STRUK
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Struk Transaksi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const Spacer(),

                          if (fotoAda)
                            InkWell(
                              onTap: () {
                                _bukaGambarPenuh(context, fotoPath);
                              },
                              child: const Row(
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
                        onTap: fotoAda
                            ? () {
                                _bukaGambarPenuh(context, fotoPath);
                              }
                            : null,
                        child: Hero(
                          tag: 'detail_foto_transaksi_${widget.transaksiId}',
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE0E3E6),
                              ),
                              image: DecorationImage(
                                image: fotoAda
                                    ? FileImage(File(fotoPath))
                                    : const AssetImage(
                                            'assets/images/placeholder.png',
                                          )
                                          as ImageProvider,
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
          );
        },
      ),
    );
  }
}
