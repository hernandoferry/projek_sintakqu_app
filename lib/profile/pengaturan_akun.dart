import 'package:flutter/material.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  _PengaturanAkunState createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  bool _isEmailNotifEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F5F5,
      ), // Menambahkan background abu-abu tipis agar Container putih Anda terlihat jelas
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
      body: Column(
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
                        Icon(Icons.person_2_outlined, color: Color(0xFF0050CC)),
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

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: const OutlineInputBorder(),
                        suffixIcon: TextButton(
                          onPressed: () {
                            print("Tombol Edit ditekan");
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xFF0050CC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Alamat e-mail',
                        border: const OutlineInputBorder(),
                        suffixIcon: TextButton(
                          onPressed: () {
                            print("Tombol Edit ditekan");
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xFF0050CC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'No.Hp',
                        border: const OutlineInputBorder(),
                        suffixIcon: TextButton(
                          onPressed: () {
                            print("Tombol Edit ditekan");
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xFF0050CC),
                              fontWeight: FontWeight.bold,
                            ),
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
                        Icon(Icons.language_outlined, color: Color(0xFF0050CC)),
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
                      style: TextStyle(fontSize: 14, color: Color(0XFF0050CC)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
