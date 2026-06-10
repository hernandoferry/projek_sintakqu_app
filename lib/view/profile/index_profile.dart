import 'package:flutter/material.dart';
import 'package:sintakqu/database/db_helper.dart';
import 'package:sintakqu/login.dart';
import 'package:sintakqu/view/profile/keamanan.dart';
import 'package:sintakqu/view/profile/pengaturan_akun.dart';
import 'package:sintakqu/view/profile/pusat_bantuan.dart';

class IndexProfile extends StatefulWidget {
  const IndexProfile({super.key});

  @override
  State<IndexProfile> createState() => _IndexProfileState();
}

class _IndexProfileState extends State<IndexProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF7FAFD),
        title: Text(
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
              onPressed: () {
                // Aksi saat ikon notifikasi ditekan
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          Image.asset("assets/images/user_dummy.png"),
          SizedBox(height: 10),
          Text(
            "Jhon Doe Wijaya",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color(0xFF181C1E),
            ),
          ),
          Center(
            child: Container(
              width: 152,
              height: 26,
              decoration: BoxDecoration(
                color: Color(0xFFDAE1FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: 5,
                      bottom: 5,
                      right: 8,
                    ),
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

          SizedBox(height: 24),
          Container(
            width: 358,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0XFFFFFFFF),
            ),
            child: Column(
              children: [
                Padding(
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
                                builder: (context) => const PengaturanAkun(),
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
                        child: Icon(Icons.security, color: Color(0xFF0050CC)),
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
                                builder: (context) => const PusatBantuan(),
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
                              content: Text('tabel transaksi di kosongkan '),
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
                        child: Icon(Icons.logout, color: Color(0xFFBA1A1A)),
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
  }
}
