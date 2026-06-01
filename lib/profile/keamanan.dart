import 'package:flutter/material.dart';

class Keamanan extends StatefulWidget {
  const Keamanan({super.key});

  @override
  _KeamananState createState() => _KeamananState();
}

class _KeamananState extends State<Keamanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keamanan",
          style: TextStyle(
            color: Color(0xFF181C1E),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFFF7FAFD),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x1A0050CC), height: 1.0),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 24),
                Icon(Icons.security, size: 35),
                SizedBox(height: 16),
                Text(
                  "Pengaturan keamanan akun dan perangkat anda",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0XFF44474E),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 16),
            child: Text(
              "KREDENSIAL",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF44474E),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ListTile(
                leading: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF0050CC),
                ), // Ikon kiri
                title: const Text(
                  "Ubah Kata Sandi",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                subtitle: const Text(
                  "Ganti password akun kamu secara berkala",
                ), // Teks bawah
                trailing: const Icon(Icons.chevron_right), // Panah kanan
                onTap: () {
                  // Aksi ketika menu diklik
                  print("Menu Ganti Password diklik");
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 16),
            child: Text(
              "PERLINDUNGAN TAMBAHAN",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF44474E),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ListTile(
                leading: const Icon(
                  Icons.phonelink_lock,
                  color: Color(0xFF0050CC),
                ),
                title: const Text(
                  "Verifikasi 2 Langkah",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                subtitle: const Text("Amankan akun dengan kode verifikasi HP"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  print("Menu 2FA diklik");
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 16),
            child: Text(
              "PERANGKAT YANG TERHUBUNG",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF44474E),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ListTile(
                leading: const Icon(
                  Icons.phone_android,
                  color: Color(0xFF0050CC),
                  size: 28,
                ),
                title: const Row(
                  children: [
                    Text(
                      "Samsung Galaxy S23",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    // Tag penanda perangkat ini sedang aktif
                    Text(
                      "Perangkat ini",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                subtitle: const Text("Jakarta, Indonesia • Aktif sekarang"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
