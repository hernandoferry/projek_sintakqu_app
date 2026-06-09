import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart';

class EditTransaksiHelper extends StatefulWidget {
  final Map<String, dynamic> transaksi;
  final Function()
  onSaved; // Callback untuk me-refresh data di halaman utama setelah simpan

  const EditTransaksiHelper({
    super.key,
    required this.transaksi,
    required this.onSaved,
  });

  @override
  State<EditTransaksiHelper> createState() => _EditTransaksiHelperState();
  // _EditTransaksiHelperState createState() => _EditTransaksiHelperState();
}

class _EditTransaksiHelperState extends State<EditTransaksiHelper> {
  late TextEditingController txtKeterangan;
  late TextEditingController txtKategori;
  late TextEditingController txtNominal;
  String? gambarPathTerpilih;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Inisialisasi data lama dari widget utama
    txtKeterangan = TextEditingController(
      text: widget.transaksi['keterangan'].toString(),
    );
    txtKategori = TextEditingController(
      text: widget.transaksi['kategori'].toString(),
    );
    txtNominal = TextEditingController(
      text: widget.transaksi['nominal'].toString(),
    );
    gambarPathTerpilih = widget.transaksi['gambar']?.toString();
  }

  @override
  void dispose() {
    txtKeterangan.dispose();
    txtKategori.dispose();
    txtNominal.dispose();
    super.dispose();
  }

  Future<void> _ambilGambar(ImageSource source) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (file != null) {
      setState(() {
        gambarPathTerpilih = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Transaksi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // PREVIEW GAMBAR
            Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFC5C6CF)),
                    ),
                    child:
                        gambarPathTerpilih != null &&
                            gambarPathTerpilih!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image.file(
                              File(gambarPathTerpilih!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Belum ada bukti gambar",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () => _ambilGambar(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library, size: 16),
                        label: const Text(
                          "Galeri",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () => _ambilGambar(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt, size: 16),
                        label: const Text(
                          "Kamera",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: txtKeterangan,
              decoration: const InputDecoration(
                labelText: "Keterangan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: txtKategori,
              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: txtNominal,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nominal (Rp)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // TOMBOL SIMPAN
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0050CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  // Menggunakan DbHelper dari import database Anda
                  await DbHelper().updateTransaksi(
                    int.parse(widget.transaksi['id'].toString()),
                    txtKeterangan.text,
                    txtKategori.text,
                    double.tryParse(txtNominal.text) ?? 0.0,
                    gambarPathTerpilih,
                  );

                  if (!context.mounted) {
                    return; // Mengamankan async gap sesuai standar linter
                  }

                  Navigator.pop(context);
                  widget.onSaved(); // Panggil fungsi refresh di halaman utama
                },
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
