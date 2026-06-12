import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintakqu/database/db_helper.dart';
import 'package:sintakqu/login.dart';
import 'package:sintakqu/view/profile/keamanan.dart';
import 'package:sintakqu/view/profile/pengaturan_akun.dart';
import 'package:sintakqu/view/profile/pusat_bantuan.dart';

class IndexProfile extends StatefulWidget {
  final String defaultImageUrl;
  const IndexProfile({super.key, this.defaultImageUrl = ""});

  @override
  State<IndexProfile> createState() => _IndexProfileState();
}

class _IndexProfileState extends State<IndexProfile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Menggunakan objek Future biasa untuk menampung data gabungan
  late Future<Map<String, dynamic>?> _ambilDataUser;

  @override
  void initState() {
    super.initState();
    // 1. Ambil data gabungan saat halaman di-init, lalu ekstrak fotonya
    _ambilDataUser = _inisialisasiDataUser();
  }

  // Fungsi pembantu untuk memuat data user sekalian menyiapkan file gambar
  Future<Map<String, dynamic>?> _inisialisasiDataUser() async {
    final data = await DbHelper().getDataLoggeduser();
    if (data != null && data['foto_profil'] != null) {
      String path = data['foto_profil'];
      if (path.isNotEmpty) {
        setState(() {
          _imageFile = File(path); // Menetapkan nilai agar CircleAvatar sinkron
        });
      }
    }
    return data;
  }

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("Pilih Sumber : "),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Buka Galeri'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Buka Kamera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        int hasilUpdate = await DbHelper().updateProfileImage(pickedFile.path);

        if (!mounted) return;

        if (hasilUpdate > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto profil berhasil diperbarui!'),
              backgroundColor: Colors.green,
            ),
          );

          // 2. Refresh FutureBuilder agar sinkronisasi data internal tetap terjaga
          setState(() {
            _ambilDataUser = _inisialisasiDataUser();
          });
        }
      }
    } catch (e) {
      debugPrint("Gagal mengambil gambar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF7FAFD),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Memastikan panah back tersembunyi
        backgroundColor: const Color(0XFFF7FAFD),
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFF0050CC),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFF0050CC),
              ),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      // 3. Memindahkan FutureBuilder ke bagian paling atas setelah SingleChildScrollView
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _ambilDataUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Gagal memuat data profil'));
          }

          final userData = snapshot.data!;
          final String setNamaUser = userData['nama_lengkap'] ?? 'Pengguna';

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : (widget.defaultImageUrl.isNotEmpty
                                  ? NetworkImage(widget.defaultImageUrl)
                                  : null),
                        child:
                            _imageFile == null && widget.defaultImageUrl.isEmpty
                            ? const Icon(
                                Icons.male_outlined,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showPickerOptions(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0050CC),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Menampilkan nama pengguna yang didapatkan dari pembungkus FutureBuilder
                Text(
                  setNamaUser,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF181C1E),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Container(
                    width: 152,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDAE1FF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, right: 8),
                          child: Icon(
                            Icons.check_circle,
                            color: Color(0XFF003FA4),
                            size: 14,
                          ),
                        ),
                        Text(
                          "Standard Account",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF003FA4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 358,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0XFFFFFFFF),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(
                              "ACCOUNT SETTINGS",
                              style: TextStyle(
                                color: Color(0XFF44474E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Color(0x4DC5C6CF)),

                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0x1A0050CC),
                              radius: 20,
                              child: Icon(
                                Icons.manage_accounts,
                                color: Color(0xFF0050CC),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PengaturanAkun(),
                                    ),
                                  );
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Pengaturan Akun",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF181C1E),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0x1A0050CC),
                              radius: 20,
                              child: Icon(
                                Icons.security,
                                color: Color(0xFF0050CC),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Keamanan(),
                                    ),
                                  );
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Keamanan",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF181C1E),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0x1A0050CC),
                              radius: 20,
                              child: Icon(
                                Icons.contact_support,
                                color: Color(0xFF0050CC),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PusatBantuan(),
                                    ),
                                  );
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Pusat Bantuan",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF181C1E),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0x1A0050CC),
                              radius: 20,
                              child: Icon(
                                Icons.contact_support,
                                color: Color(0xFF0050CC),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () async {
                                await DbHelper().insert20DataDummyMei();

                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      '20 Data Dummy Mei Berhasil Ditambahkan!',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Insert Dummy Data",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF181C1E),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0x1A0050CC),
                              radius: 20,
                              child: Icon(
                                Icons.contact_support,
                                color: Color(0xFF0050CC),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () async {
                                await DbHelper().deleteAllTransaksiRaw();

                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'tabel transaksi di kosongkan ',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Kosongkan table transaksi",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF181C1E),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0x1ABA1A1A),
                              radius: 20,
                              child: Icon(
                                Icons.logout,
                                color: Color(0xFFBA1A1A),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () async {
                                await DbHelper().logoutUser();
                                if (context.mounted) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                    (Route<dynamic> route) =>
                                        false, // Menghapus semua halaman sebelumnya dari stack
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Keluar Aplikasi",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFBA1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
