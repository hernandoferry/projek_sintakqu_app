import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({super.key});

  @override
  State createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  // Controller untuk mengambil teks dari TextFormField
  final _passwordLamaController = TextEditingController();
  final _passwordBaruController = TextEditingController();
  final _konfirmasiPasswordController = TextEditingController();

  // Status untuk sembunyi/lihat password
  bool _obscureLama = true;
  bool _obscureBaru = true;
  bool _obscureKonfirmasi = true;

  @override
  void dispose() {
    _passwordLamaController.dispose();
    _passwordBaruController.dispose();
    _konfirmasiPasswordController.dispose();
    super.dispose();
  }

  Future<void> _gantiPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final user = _auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User belum login")));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Re-authenticate menggunakan password lama
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _passwordLamaController.text.trim(),
      );

      await user.reauthenticateWithCredential(credential);

      // Update password baru
      await user.updatePassword(_passwordBaruController.text.trim());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password berhasil diubah"),
          backgroundColor: Colors.green,
        ),
      );

      _passwordLamaController.clear();
      _passwordBaruController.clear();
      _konfirmasiPasswordController.clear();

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String pesan = "Terjadi kesalahan";

      switch (e.code) {
        case "wrong-password":
        case "invalid-credential":
          pesan = "Password lama salah !";
          break;

        case "weak-password":
          pesan = "Password baru terlalu lemah";
          break;

        case "requires-recent-login":
          pesan = "Silakan login ulang terlebih dahulu";
          break;

        default:
          pesan = e.message ?? "Terjadi kesalahan";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(pesan)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ganti Kata Sandi',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xFFF7FAFD),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x1A0050CC), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 16),
              child: const Center(
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Icon(Icons.enhanced_encryption, size: 35),
                    SizedBox(height: 16),
                    Text(
                      "Amankan Akun Anda",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF44474E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Jangan gunakan tanggal lahir atau kata yang umum karena hal tersebut rentan dan mudah ditebak.',
                      style: TextStyle(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF7FAFD),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // 1. Password Lama
                            TextFormField(
                              controller: _passwordLamaController,
                              obscureText: _obscureLama,
                              decoration: InputDecoration(
                                labelText: 'Password Lama',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureLama
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscureLama = !_obscureLama,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password lama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),
                            // 2. Password Baru
                            TextFormField(
                              controller: _passwordBaruController,
                              obscureText: _obscureBaru,
                              decoration: InputDecoration(
                                labelText: 'Password Baru',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureBaru
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscureBaru = !_obscureBaru,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password baru tidak boleh kosong';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // 3. Konfirmasi Password Baru
                            TextFormField(
                              controller: _konfirmasiPasswordController,
                              obscureText: _obscureKonfirmasi,
                              decoration: InputDecoration(
                                labelText: 'Konfirmasi Password Baru',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureKonfirmasi
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscureKonfirmasi =
                                        !_obscureKonfirmasi,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi password tidak boleh kosong';
                                }
                                if (value != _passwordBaruController.text) {
                                  return 'Password tidak cocok';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            ElevatedButton(
                              onPressed: _isLoading ? null : _gantiPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0XFF0055CC),
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: const Color(
                                  0XFF0055CC,
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                        backgroundColor: Color(0XFF0055CC),
                                      ),
                                    )
                                  : const Text("Simpan Kata Sandi Baru"),
                            ),

                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
