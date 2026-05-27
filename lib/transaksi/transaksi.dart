import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // Import package

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final _formKey = GlobalKey<FormState>();
  String? selected;

  //pendefinisian variabel untuk image_picker
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality:
            80, // Mengompres kualitas gambar (0-100) agar file tidak terlalu besar
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(
            pickedFile.path,
          ); // Menyimpan file gambar terpilih ke variabel
        });
      }
    } catch (e) {
      print("Error mengambil gambar: $e");
    }
  }

  //fungsi untuk menampilkan pilihan upload gambar/struk belanja dari kamera atau galery dengan menggunakan widget bottomsheet
  void _showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Pilih Aksi Struk',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Kamera (Ambil Foto)'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Galeri (Pilih dari HP)'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),

              // FITUR BARU: Opsi Hapus Foto hanya muncul jika _imageFile TIDAK null
              if (_imageFile != null) ...[
                const Divider(), // Garis pembatas tipis agar rapi
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text(
                    'Hapus Foto Struk',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _imageFile = null; // Menghapus instansi file gambar
                    });
                  },
                ),
              ],
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FAFD),
        title: Row(
          children: [
            Text(
              "Tambah Transaksi",
              style: TextStyle(
                color: Color(0XFF0050CC),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Spacer(),
            Icon(Icons.notifications_none, color: Color(0xFF0050CC)),
          ],
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    width: 380,
                    height: 501,
                    decoration: BoxDecoration(color: Color(0xFFF7FAFD)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nominal Transaksi",
                          style: TextStyle(
                            color: Color(0xFF44474E),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFormField(
                          // controller: _nominalTransaksi,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: "100.000",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF181C1E),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E6),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Color(
                                  0xFFE0E0E0,
                                ), // Warna abu-abu terang
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Color(0XFF0050CC),
                                width:
                                    2.0, // Garis sedikit lebih tebal saat aktif
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Nominal transaksi harus di isi !";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 24),
                        Text(
                          "Kategori Transaksi",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF44474E),
                          ),
                        ),
                        SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          initialValue: selected,
                          isExpanded: true, // Tetap rata kanan-kiri
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E6),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ), // Warna biru tebal saat aktif
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ), // Warna merah saat error
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                          items:
                              [
                                '',
                                'Kuliner',
                                'Tagihan Listrik',
                                'Belanja Pokok',
                                'E-commerce',
                                'Tagihan Internet',
                                'Biaya Pendidikan',
                              ].map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selected = val;
                            });
                          },
                          // Tambahkan validator di sini
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tentukan kategori transaksi !';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 24),
                        Text(
                          "Unggah Struk Belanja/Barang (Opsional)",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF44474E),
                          ),
                        ),
                        SizedBox(height: 4),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            _showImageSourceBottomSheet(context);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE0E3E6),
                              ),
                              image: _imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(_imageFile!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _imageFile == null
                                ? const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cloud_upload_outlined,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Ketuk untuk upload struk belanja',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
