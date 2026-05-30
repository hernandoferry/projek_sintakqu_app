import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/profile/pengaturan_akun.dart';

class IndexProfile extends StatefulWidget {
  const IndexProfile({super.key});

  @override
  _IndexProfileState createState() => _IndexProfileState();
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
            padding: const EdgeInsets.only(
              right: 16,
            ), // Jarak ikon dari sisi kanan layar
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
          preferredSize: const Size.fromHeight(
            1.0,
          ), // Menentukan tinggi area border (1 pixel)
          child: Container(
            color: const Color(0xFFE0E3E6), // Warna garis border bawah
            height: 1.0, // Ketebalan garis border
          ),
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
            height: 419,
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
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(
                          0x1A0050CC,
                        ), // Warna latar belakang
                        radius: 20, // Mengatur ukuran total lingkaran
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
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(
                          0x1A0050CC,
                        ), // Warna latar belakang
                        radius: 20, // Mengatur ukuran total lingkaran
                        child: Icon(Icons.security, color: Color(0xFF0050CC)),
                      ),
                      SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
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
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(
                          0x1A0050CC,
                        ), // Warna latar belakang
                        radius: 20, // Mengatur ukuran total lingkaran
                        child: Icon(
                          Icons.contact_support,
                          color: Color(0xFF0050CC),
                        ),
                      ),
                      SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
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
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(
                          0x1ABA1A1A,
                        ), // Warna latar belakang
                        radius: 20, // Mengatur ukuran total lingkaran
                        child: Icon(Icons.logout, color: Color(0xFFBA1A1A)),
                      ),
                      SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
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
