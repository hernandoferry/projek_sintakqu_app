import 'package:flutter/material.dart';
import 'package:sintakqu/database/db_helper.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  State<PengaturanAkun> createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  bool _isEmailNotifEnabled = false;
  final _formKey = GlobalKey<FormState>();
  //  Definisikan Controller untuk menangkap input teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();

  // Status kontrol untuk show/hide tombol simpan dan kunci field input
  bool _isEditingNama = false;
  bool _isEditingEmail = false;
  bool _isEditingNoHp = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _muatDataAwalUser();
  }

  // Ambil data dari SQLite untuk ditampilkan pertama kali di form
  Future<void> _muatDataAwalUser() async {
    final dataUser = await DbHelper().getDataLoggeduser();
    if (dataUser != null) {
      _namaController.text = dataUser['nama_lengkap'] ?? '';
      _emailController.text = dataUser['email'] ?? '';
      _noHpController.text = dataUser['no_hp'] ?? '';
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Fungsi untuk eksekusi penyimpanan ke SQFlite
  Future<void> _simpanPerubahanData() async {
    if (_formKey.currentState!.validate()) {
      int hasil = await DbHelper().updateInformasiPersonal(
        _namaController.text.trim(),
        _emailController.text.trim(),
        _noHpController.text.trim(),
      );

      if (!mounted) return;

      if (hasil > 0) {
        setState(() {
          _isEditingNama = false;
          _isEditingEmail = false;
          _isEditingNoHp = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Informasi personal berhasil diperbarui!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Tentukan apakah ada salah satu field yang sedang dalam mode edit
    //bool sedangModeEdit = _isEditingNama || _isEditingEmail || _isEditingNoHp;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "Pengaturan Akun",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x1A0050CC), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 24,
                right: 16,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Color(0XFFFFFFFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_2_outlined,
                            color: Color(0xFF0050CC),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Informasi Personal",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0XFF181C1E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // ================= 1. FIELD NAMA LENGKAP =================
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _namaController,
                                    enabled:
                                        _isEditingNama, // Kolom tetap aman terkunci/terbuka
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Nama tidak boleh kosong'
                                        : null,
                                    decoration: const InputDecoration(
                                      labelText: 'Nama Lengkap',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // PENGUBAHAN: Tombol dipindah ke luar TextFormField agar tidak ikut terkunci
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditingNama = !_isEditingNama;
                                    });
                                  },
                                  child: Text(
                                    _isEditingNama ? 'Batal' : 'Edit',
                                    style: TextStyle(
                                      color: _isEditingNama
                                          ? Colors.red
                                          : const Color(0xFF0050CC),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ================= 2. FIELD ALAMAT EMAIL =================
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    enabled: _isEditingEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Email tidak boleh kosong'
                                        : null,
                                    decoration: const InputDecoration(
                                      labelText: 'Alamat e-mail',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditingEmail = !_isEditingEmail;
                                    });
                                  },
                                  child: Text(
                                    _isEditingEmail ? 'Batal' : 'Edit',
                                    style: TextStyle(
                                      color: _isEditingEmail
                                          ? Colors.red
                                          : const Color(0xFF0050CC),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ================= 3. FIELD NO HP =================
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _noHpController,
                                    enabled: _isEditingNoHp,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'No. HP tidak boleh kosong'
                                        : null,
                                    decoration: const InputDecoration(
                                      labelText: 'No.Hp',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditingNoHp = !_isEditingNoHp;
                                    });
                                  },
                                  child: Text(
                                    _isEditingNoHp ? 'Batal' : 'Edit',
                                    style: TextStyle(
                                      color: _isEditingNoHp
                                          ? Colors.red
                                          : const Color(0xFF0050CC),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 24,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0050CC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation:
                                2, // Memberi sedikit bayangan agar tombol terlihat menonjol
                          ),
                          onPressed:
                              _simpanPerubahanData, // Memanggil fungsi Anda
                          child: const Text(
                            'Simpan Perubahan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 24,
                right: 16,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Color(0XFFFFFFFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notification_add_outlined,
                            color: Color(0xFF0050CC),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Pengaturan Notifikasi",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0XFF181C1E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Notifikasi Email",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: const Text("Kirimkan notifikasi via email"),
                      trailing: Switch(
                        value: _isEmailNotifEnabled,
                        activeThumbColor: const Color(0xFF0050CC),
                        onChanged: (bool value) {
                          setState(() {
                            _isEmailNotifEnabled = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 24,
                right: 16,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Color(0XFFFFFFFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language_outlined,
                            color: Color(0xFF0050CC),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Pengaturan Bahasa",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0XFF181C1E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Bahasa",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: const Text("Saat ini : Bahasa Indonesia (ID)"),
                      trailing: Text(
                        "Ubah Bahasa",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF0050CC),
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
