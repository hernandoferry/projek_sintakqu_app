import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart';
import 'package:projek_sintakqu_app/register.dart';
import 'package:projek_sintakqu_app/view/home/index_home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool intipPasword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF7FAFD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 80),

              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/icon_login.png",
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.lock,
                          size: 80,
                          color: Colors.blue,
                        );
                      },
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      'SintakQu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: const Color(0XFFFFFFFF),
                  border: Border.all(color: const Color(0xFFBFBBBB), width: 1),
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF000000),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Masukan alamat email dan kata sandi akun anda',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Alamat E-mail',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Alamat email tidak boleh kosong';
                          }
                          // Regex untuk mengecek format email standar (contoh: user@mail.com)
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Format email tidak valid';
                          }
                          return null; // Return null jika input sudah benar
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          hintText: 'ex: youremail@mail.co.id',
                          hintStyle: const TextStyle(fontSize: 12),
                          fillColor: const Color(0xFFF3F9FF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Kata Sandi',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Aksi lupa kata sandi
                            },
                            child: const Text(
                              'Lupa Kata Sandi ?',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0266FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: intipPasword,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata sandi tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Kata sandi minimal harus 6 karakter';
                          }
                          return null; // Return null jika input sudah benar
                        },
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFF3F9FF),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              intipPasword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                intipPasword = !intipPasword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Tombol Login
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0266FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          onPressed: () async {
                            // 1. Validasi format input form terlebih dahulu
                            if (_formKey.currentState!.validate()) {
                              // Ambil data teks dari controller
                              String emailInput = _emailController.text.trim();
                              String passwordInput = _passwordController.text;

                              // Tampilkan loading indicator sederhana
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              try {
                                // 2. Panggil fungsi cek login dari DBHelper
                                bool isLoginSukses = await DbHelper().cekLogin(
                                  emailInput,
                                  passwordInput,
                                );

                                // Tutup dialog loading
                                Navigator.pop(context);

                                // 3. Cek hasil dari database
                                if (isLoginSukses) {
                                  // JIKA COCOK: Berikan notifikasi sukses dan pindah ke Home
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Berhasil!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const IndexHome(),
                                    ),
                                  );
                                } else {
                                  // JIKA SALAH: Tampilkan pesan error akun tidak terdaftar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Email atau Kata Sandi salah!',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } catch (e) {
                                // Tutup dialog loading jika terjadi error sistem/database
                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Terjadi kesalahan database: $e',
                                    ),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Teks Daftar Akun Baru
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Belum punya akun? ',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: 'Daftar Sekarang',
                                style: const TextStyle(
                                  color: Color(0xFF0266FF),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Register(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
