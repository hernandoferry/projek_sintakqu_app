import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool intipPasword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color(0XFFF7FAFD),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 80,
                            left: 103,
                            right: 107,
                          ),
                          child: Image.asset("assets/images/icon_login.png"),
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
                  const SizedBox(height: 10),
                  Container(
                    width: 349,
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color(0XFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFFBFBBBB),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 14, top: 15),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF000000),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'Masukan alamat email dan kata sandi akun anda',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(
                            'Alamat E-mail',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
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
                                const Row(
                                  children: [
                                    Text(
                                      'Kata Sandi',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Lupa Kata Sandi ?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0266FF),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  obscureText: intipPasword,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFF3F9FF),
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
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          intipPasword = !intipPasword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 21),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Text('boom');
                                  },
                                  child: Text(
                                    'MASUK',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22),
                                Divider(),

                                Row(
                                  children: [
                                    Spacer(),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.grey, // Warna teks biasa
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: 'Belum memiliki akun ? ',
                                          ),
                                          TextSpan(
                                            text: 'DAFTAR DISINI',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Register(),
                                                  ),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),

                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: EdgeInsets.only(left: 140),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: Color(0xFF0266FF),
                          size: 15,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Secure SSL Encription",
                          style: TextStyle(
                            color: Color(0xFFBFBBBB),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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
    );
  }
}
