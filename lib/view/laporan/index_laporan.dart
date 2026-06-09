import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart';
import 'package:projek_sintakqu_app/helpers/edit_transaksi_helper.dart';
import 'package:projek_sintakqu_app/helpers/state_pencarian_helper.dart';
import 'package:projek_sintakqu_app/view/laporan/bulanan_laporan.dart';
import 'package:projek_sintakqu_app/view/laporan/tahunan_laporan.dart';

class IndexLaporan extends StatefulWidget {
  const IndexLaporan({super.key});

  @override
  State<IndexLaporan> createState() => _IndexLaporanState();
}

class _IndexLaporanState extends State<IndexLaporan> {
  // 1. Inisialisasi controller dan penampung data di atas override build
  final TextEditingController _dateController = TextEditingController();
  List<Map<String, dynamic>> _hasilPencarian = [];

  // 2. Fungsi saat TextField di-tap
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Ubah tanggal ke format SQLite (YYYY-MM-DD)
      String formatDb = DateFormat('yyyy-MM-dd').format(picked);

      // Ubah tanggal ke format UI TextField (DD-MM-YYYY)
      String formatUi = DateFormat('dd-MM-yyyy').format(picked);

      // Ambil data dari database Sqflite
      final data = await DbHelper().cariTransaksiMulaiTanggal(formatDb);

      setState(() {
        _dateController.text = formatUi;
        // Menyimpan hasil data untuk ditampilkan di ListView
        _hasilPencarian = data;
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FAFD),
        title: Row(
          children: [
            Text(
              "Laporan",
              style: TextStyle(
                color: Color(0XFF0050CC),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Spacer(),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BulananLaporan()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFFE4D329),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 40,
                      right: 40,
                    ),
                    child: Text(
                      "Bulanan",
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TahunanLaporan(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF3852B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 38,
                      right: 38,
                    ),
                    child: Text(
                      "Tahunan",
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Container(
              width: 400,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x01FFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: const Color(0x80E0E3E6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Pencarian data transaksi",
                    style: TextStyle(fontSize: 16, color: Color(0XFF44474E)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Pilih tanggal transaksi",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFF44474E),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _pilihTanggal(context),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF1F4F7),
                      hintText: "DD-MM-YYYY",
                      prefixIcon: const Icon(Icons.calendar_today),

                      suffixIcon: _dateController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Color(0xFF8E8E93),
                              ),
                              onPressed: () {
                                setState(() {
                                  _dateController.clear();
                                  _hasilPencarian.clear();
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFC5C6CF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5C6CF),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: _hasilPencarian.isEmpty
                ? StatePencarianHelper(
                    belumCari: _dateController
                        .text
                        .isEmpty, // Memperbaiki kondisi helper secara dinamis
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    itemCount: _hasilPencarian.length,
                    itemBuilder: (context, index) {
                      final transaksi = _hasilPencarian[index];
                      final bool isPengeluaran =
                          transaksi['jenis'] == 'pengeluaran';
                      final double nominal =
                          double.tryParse(transaksi['nominal'].toString()) ??
                          0.0;

                      // Format angka nominal menjadi Rp 150.000
                      final String formatUang = nominal
                          .toStringAsFixed(0)
                          .replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]}.',
                          );

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFEBEBF0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isPengeluaran
                                    ? const Color(0xFFFFEBEE)
                                    : const Color(0xFFE8F5E9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isPengeluaran
                                    ? Icons.arrow_outward
                                    : Icons.south_west,
                                color: isPengeluaran
                                    ? Colors.red
                                    : Colors.green,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaksi['keterangan'] ??
                                        'Tanpa Keterangan',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1C1C1E),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    transaksi['kategori'] ?? 'Umum',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF8E8E93),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ✨ KELOMPOK NOMINAL & TOMBOL AKSI
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Nominal Transaksi (Warna diubah dinamis: Merah untuk pengeluaran, Hijau untuk pemasukan)
                                Text(
                                  "${isPengeluaran ? '-' : '-'} Rp $formatUang",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ), // Jarak ke tombol aksi
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                      ),

                                      builder: (context) => EditTransaksiHelper(
                                        transaksi: transaksi,
                                        onSaved: () async {
                                          // Fungsi penyegaran otomatis setelah data disimpan
                                          String formatDb =
                                              DateFormat('yyyy-MM-dd').format(
                                                DateFormat(
                                                  'dd-MM-yyyy',
                                                ).parse(_dateController.text),
                                              );

                                          final dataTerbaru = await DbHelper()
                                              .cariTransaksiMulaiTanggal(
                                                formatDb,
                                              );

                                          setState(() {
                                            _hasilPencarian = dataTerbaru;
                                          });
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Transaksi berhasil diperbarui",
                                              ),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    // Tampilkan dialog konfirmasi
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          title: const Text(
                                            "Hapus Transaksi?",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: const Text(
                                            "Apakah Anda yakin ingin menghapus data transaksi ini secara permanent?",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF4A4A4A),
                                            ),
                                          ),
                                          actions: [
                                            // Tombol Batal
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(dialogContext);
                                              },
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            // Tombol Konfirmasi Oke/Hapus
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(dialogContext);

                                                // Pastikan nama kolom 'id' sesuai dengan primary key di database Anda
                                                await DbHelper().hapusTransaksi(
                                                  transaksi['id'],
                                                );

                                                String formatDb =
                                                    DateFormat(
                                                      'yyyy-MM-dd',
                                                    ).format(
                                                      DateFormat(
                                                        'dd-MM-yyyy',
                                                      ).parse(
                                                        _dateController.text,
                                                      ),
                                                    );
                                                final dataTerbaru =
                                                    await DbHelper()
                                                        .cariTransaksiMulaiTanggal(
                                                          formatDb,
                                                        );

                                                setState(() {
                                                  _hasilPencarian = dataTerbaru;
                                                });
                                                if (!context.mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Transaksi berhasil dihapus",
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Hapus",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
