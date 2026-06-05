import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart'; // Tambahkan import database
import 'package:projek_sintakqu_app/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Tambahkan Form Key untuk validasi input
  final _formKey = GlobalKey<FormState>();

  // Tambahkan Controller untuk mengambil teks inputan
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(); // Ditambahkan untuk password database

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF7FAFD),
      body: SingleChildScrollView(
        // Ditambahkan agar layar aman bisa di-scroll saat mengetik
        child: Column(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Image.asset(
                "assets/images/icon_register.png",
                width: 165,
                height: 165,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.app_registration,
                  size: 100,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text(
              'SintakQu',
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 30.5,
                right: 30.5,
              ), // Perbaikan dari EdgeInsetsGeometry
              child: Center(
                child: Text(
                  'Gabung dengan SintakQu untuk memulai mengelola keuangan Keluarga anda',
                  style: TextStyle(color: Color(0xFF000000), fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Container utama Form Box
            Container(
              width: 349,
              // Hapus height kaku (379) agar kotak otomatis memanjang jika ada teks error dari validator
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: const Color(0xFFBFBBBB), width: 1.0),
              ),
              padding: const EdgeInsets.only(
                bottom: 16,
              ), // Beri jarak bawah container
              child: Form(
                key: _formKey, // Pasang Form Key disini
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFormField(
                        controller: _namaController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama lengkap tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: _inputDecoration('Ex: Sinta Qu'),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Alamat E-mail :",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                        decoration: _inputDecoration(
                          'Ex: sintaQudummy@email.com',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "No.Hp/Wa :",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFormField(
                        controller: _noHpController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nomor HP tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: _inputDecoration('Ex: 087123456789'),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // --- INPUT KATA SANDI (Tambahan Baru Agar Bisa Sinkron Saat Login) ---
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Kata Sandi :",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata sandi tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Kata sandi minimal 6 karakter';
                          }
                          return null;
                        },
                        decoration: _inputDecoration('Masukkan Kata Sandi'),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // --- TOMBOL DAFTAR ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed:
                            _prosesDaftarUser, // Panggil fungsi pendaftaran database
                        child: const Text(
                          'DAFTAR SEKARANG',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // --- TEKS LINK PINDAH KE LOGIN ---
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        children: [
                          const TextSpan(text: 'Saya sudah memiliki akun? '),
                          TextSpan(
                            text: 'Masuk',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _prosesDaftarUser() async {
    if (_formKey.currentState!.validate()) {
      // Munculkan efek loading berputarshowDialog(context: context,barrierDismissible: false,builder: (context) => const Center(child: CircularProgressIndicator()),);
      Map<String, dynamic> dataRegistrasi = {
        'nama_lengkap': _namaController.text.trim(),
        'email': _emailController.text.trim(),
        'no_hp': _noHpController.text.trim(),
        'password': _passwordController.text,
        'is_login': 0,
        'status': 'aktif',
      };
      int hasil = await DbHelper().registrasiUser(dataRegistrasi);
      Navigator.pop(context);
      if (hasil == -1) {
        _notifikasiPesan('Alamat Email ini sudah terdaftar!', Colors.red);
      } else if (hasil > 0) {
        _notifikasiPesan('Pendaftaran Berhasil! Silakan masuk.', Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        _notifikasiPesan('Pendaftaran gagal sistem error.', Colors.orange);
      }
    }
  }

  void _notifikasiPesan(String pesan, Color warna) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(pesan), backgroundColor: warna));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF3F9FF),
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFBFBBBB), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }
}
