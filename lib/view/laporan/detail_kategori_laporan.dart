import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart';
import 'package:projek_sintakqu_app/model/transaksi_model.dart';

class DetailKategoriLaporan extends StatefulWidget {
  final String namaKategori;
  final int bulanAngka;
  final String namaBulan;

  const DetailKategoriLaporan({
    super.key,
    required this.namaKategori,
    required this.bulanAngka,
    required this.namaBulan,
  });

  @override
  State<DetailKategoriLaporan> createState() => _DetailKategoriLaporanState();
}

class _DetailKategoriLaporanState extends State<DetailKategoriLaporan> {
  // Fungsi pembantu untuk mencocokkan ikon berdasarkan nama kategori secara dinamis
  IconData dapatkanIkonKategori(String kategori) {
    switch (kategori) {
      case 'Belanja Bulanan':
        return Icons.shopping_basket;
      case 'E-Commerce & Belanja':
        return Icons.shopping_bag;
      case 'Hiburan & Gaya Hidup':
        return Icons.movie;
      case 'Internet & Komunikasi':
        return Icons.language;
      case 'Kesehatan':
        return Icons.local_hospital;
      case 'Kuliner & Makanan':
        return Icons.restaurant;
      case 'Pendidikan':
        return Icons.school;
      case 'Sosial & Donasi':
        return Icons.volunteer_activism;
      case 'Tagihan Rumah Tangga':
        return Icons.electric_bolt;
      case 'Transportasi':
        return Icons.directions_car;
      default:
        return Icons.wallet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kategori"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DbHelper().getTransaksiDanTotalPerKategoriBulan(
          widget.namaKategori,
          widget.bulanAngka,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Map<String, dynamic>> dataRaw = snapshot.data ?? [];

          // Tampilan jika tidak ada transaksi pada kategori di bulan ini
          if (dataRaw.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada transaksi di kategori ini.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // ✨ AMBIL TOTAL LANGSUNG DARI BARIS PERTAMA HASIL SQL WINDOW FUNCTION
          final double totalPengeluaranKategori =
              (dataRaw[0]['total_pengeluaran_kategori'] as num).toDouble();

          // Format Rupiah untuk Total Ringkasan Card Atas
          String formatTotalRupiah = totalPengeluaranKategori
              .toStringAsFixed(0)
              .replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]}.',
              );

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // 1. DYNAMIC GRADIENT CARD TOTAL PENGELUARAN
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    width: double.infinity,
                    height: 149,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF001A41), Color(0xFF0050CC)],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                dapatkanIkonKategori(widget.namaKategori),
                                color: const Color(0x60FFFFFF),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Pengeluaran ${widget.namaBulan} ${DateTime.now().year}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0x60FFFFFF),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.namaKategori,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 33,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "TOTAL Rp $formatTotalRupiah",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFFDCC3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // SECTION TITLE RIWAYAT
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                  child: Row(
                    children: const [
                      Text(
                        "Riwayat Transaksi",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Urutkan",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0XFF0050CC),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 2. DYNAMIC TRANSACTIONS LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataRaw.length,
                  itemBuilder: (context, index) {
                    // Mapping Map SQLite ke TransaksiModel
                    final transaksi = TransaksiModel.fromMap(dataRaw[index]);

                    final String judul = transaksi.keterangan.isEmpty
                        ? '-'
                        : transaksi.keterangan;
                    final String tanggal =
                        "${transaksi.createdAt.day} ${widget.namaBulan} ${transaksi.createdAt.year}";

                    // Format Rupiah untuk Item List
                    String formatItemRupiah = transaksi.nilaiTransaksi
                        .toStringAsFixed(0)
                        .replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]}.',
                        );

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(8),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0XFF0050CC),
                              child: Icon(
                                dapatkanIkonKategori(transaksi.kategoriTrans),
                                color: const Color(0xFFFFFFFF),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        judul,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xFF212121),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        tanggal,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Rp $formatItemRupiah",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0050CC),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
