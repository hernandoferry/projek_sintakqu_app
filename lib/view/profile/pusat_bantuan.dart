import 'package:flutter/material.dart';

class PusatBantuan extends StatefulWidget {
  const PusatBantuan({super.key});

  @override
  _PusatBantuanState createState() => _PusatBantuanState();
}

class _PusatBantuanState extends State<PusatBantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pusat Bantuan",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF181C1E),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x1A0050CC), height: 1.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 24),
                Icon(Icons.contact_support_outlined, size: 53),
                SizedBox(height: 8),
                Text(
                  "Ada yang bisa kami bantu ?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0XFF44474E),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 187,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0XFFFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0x1A0050CC),
                        child: const Icon(
                          Icons.question_mark,
                          color: Color(0xFF0050CC),
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "FAQ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF181C1E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 187,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0XFFFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0x1A0050CC),
                        child: const Icon(
                          Icons.support_agent,
                          color: Color(0xFF0050CC),
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Kontak Support",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF181C1E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 187,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0XFFFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0x1A0050CC),
                        child: const Icon(
                          Icons.play_circle,
                          color: Color(0xFF0050CC),
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Tutorial",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF181C1E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 187,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0XFFFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0x1A0050CC),
                        child: const Icon(
                          Icons.policy,
                          color: Color(0xFF0050CC),
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Syarat & Ketentuan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF181C1E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          Container(
            width: 390,
            height: 182,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(7),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft, // Titik awal gradasi (stop 0%)
                end: Alignment.bottomRight, // Titik akhir gradasi (stop 100%)
                colors: [
                  Color(
                    0xFFD8E2FF,
                  ), // Warna pertama (D8E2FF dengan opasitas 100%)
                  Color(
                    0xFFFFFFFF,
                  ), // Warna kedua (FFFFFF dengan opasitas 100%)
                ],
                stops: [0.0, 1.0], // Menentukan posisi stop (0% dan 100%)
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 24),
                Text(
                  "Need immediate Assistance ? ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF001A41),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(left: 30.5, right: 30.5),
                  child: Text(
                    "Our support agent are available to help you resolve any issue",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0XFF32466F),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0050CC),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat),
                      SizedBox(width: 8),
                      Text("Live Chat"),
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
