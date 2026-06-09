import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class Keamanan extends StatefulWidget {
  const Keamanan({super.key});

  @override
  State<Keamanan> createState() => _KeamananState();
}

class _KeamananState extends State<Keamanan> {
  Future<String> getNamaPerangkat() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        // JIKA BERJALAN DI EMULATOR: deteksi dan berikan nama yang ramah dibaca
        if (!androidInfo.isPhysicalDevice) {
          return "Android Emulator";
        }

        // Jika di perangkat fisik asli (Contoh: "Samsung SM-S911B")
        return "${androidInfo.brand.toUpperCase()} ${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        // JIKA BERJALAN DI SIMULATOR IOS
        if (!iosInfo.isPhysicalDevice) {
          return "iOS Simulator";
        }

        return iosInfo.utsname.machine;
      }
    } catch (e) {
      return "Gagal mendeteksi perangkat";
    }

    return "Perangkat tidak dikenal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF7FAFD,
      ), // Menambahkan background dasar layout
      appBar: AppBar(
        title: const Text(
          "Keamanan",
          style: TextStyle(
            color: Color(0xFF181C1E),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFFF7FAFD),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x1A0050CC), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        // Ditambahkan agar layar bisa di-scroll jika overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
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
            const SizedBox(height: 24),
            const Padding(
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
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  leading: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF0050CC),
                  ),
                  title: const Text(
                    "Ubah Kata Sandi",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  subtitle: const Text(
                    "Ganti password akun kamu secara berkala",
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
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
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  leading: const Icon(
                    Icons.phonelink_lock,
                    color: Color(0xFF0050CC),
                  ),
                  title: const Text(
                    "Verifikasi 2 Langkah",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  subtitle: const Text(
                    "Amankan akun dengan kode verifikasi HP",
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
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
            const SizedBox(height: 8),

            // PERBAIKAN UTAMA: Memasukkan FutureBuilder langsung ke dalam struktur komponen kartu
            FutureBuilder<String>(
              future: getNamaPerangkat(),
              builder: (context, snapshot) {
                String namaMesin = snapshot.data ?? "Memuat nama perangkat...";

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      leading: const Icon(
                        Icons.phone_android,
                        color: Color(0xFF0050CC),
                        size: 28,
                      ),
                      title: Row(
                        children: [
                          // Menggunakan data dinamis hasil deteksi
                          Expanded(
                            child: Text(
                              namaMesin,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Perangkat ini",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      subtitle: const Text(
                        "Jakarta, Indonesia • Aktif sekarang",
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
