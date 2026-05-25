import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80),
          Center(
            child: Image.asset(
              "assets/images/icon_register.png",
              width: 165,
              height: 165,
            ),
          ),
          Text(
            'SintakQu',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 30.5, right: 30.5),
            child: Center(
              child: Text(
                'Gabung dengnan SintakQu untuk memulai mengelola keuangan Keluarga anda',
                style: TextStyle(color: Color(0xFF000000), fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(padding: EdgeInsetsGeometry.only(left: 13, right: 13)),
          Container(
            width: 349,
            height: 379,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Color(0xFFBFBBBB), width: 1.0),
            ),
            child: Column(
              children: [
                Padding(
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
                  padding: EdgeInsets.only(left: 9, right: 14),
                  child: SizedBox(
                    width: 326,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF3F9FF),
                        hintText: 'Ex: Sinta Qu',
                        hintStyle: TextStyle(fontSize: 12),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Color(0xFFBFBBBB),
                            width: 1.0, // Ketebalan 1px
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Color(0xFFBFBBBB),
                            width: 1.0, // Ketebalan 1px
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Padding(
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
                  padding: EdgeInsets.only(left: 9, right: 14),
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF3F9FF),
                      hintText: "Ex: sintaQudummy@email.com",
                      hintStyle: TextStyle(fontSize: 12),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFFBFBBBB),
                          width: 1.0, // Ketebalan 1px
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFFBFBBBB),
                          width: 1.0, // Ketebalan 1px
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Padding(
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
                  padding: EdgeInsets.only(left: 9, right: 14),
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF3F9FF),
                      hintText: "Ex: 087123456789",
                      hintStyle: TextStyle(fontSize: 12),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFFBFBBBB),
                          width: 1.0, // Ketebalan 1px
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFFBFBBBB),
                          width: 1.0, // Ketebalan 1px
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 9, right: 14),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Text('boom');
                    },
                    child: Text(
                      'DAFTAR SEKARANG',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey, // Warna teks biasa
                    ),
                    children: [
                      const TextSpan(text: 'Saya sudah memiliki akun? '),
                      TextSpan(
                        text: 'Masuk',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 16),
            child: Text(
              "SintakQu berkomitmen untuk melindungi data dan privasi anda dengan keamanan standar tinggi",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFBFBBBB),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
