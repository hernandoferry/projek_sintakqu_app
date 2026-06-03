import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_sintakqu_app/laporan/bulanan_laporan.dart';
import 'package:projek_sintakqu_app/laporan/tahunan_laporan.dart';

class IndexLaporan extends StatefulWidget {
  const IndexLaporan({super.key});

  @override
  _IndexLaporanState createState() => _IndexLaporanState();
}

class _IndexLaporanState extends State<IndexLaporan> {
  final TextEditingController _dateController = TextEditingController();

  // Fungsi untuk menampilkan kalender popup
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? tanggalDipilih = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Tanggal awal saat kalender dibuka
      firstDate: DateTime(2000), // Batas minimum tahun yang bisa dipilih
      lastDate: DateTime(2100), // Batas maksimum tahun yang bisa dipilih
    );

    if (tanggalDipilih != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(tanggalDipilih);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FAFD),
        title: Row(
          children: [
            Text(
              "Laporan",
              style: TextStyle(
                color: Color(0XFF0050CC),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Spacer(),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BulananLaporan()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFFE4D329),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 40,
                      right: 40,
                    ),
                    child: Text(
                      "Bulanan",
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TahunanLaporan(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF3852B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 38,
                      right: 38,
                    ),
                    child: Text(
                      "Tahunan",
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Container(
              width: 400,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x01FFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: const Color(0x80E0E3E6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Pencarian data transaksi",
                    style: TextStyle(fontSize: 16, color: Color(0XFF44474E)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Pilih tanggal transaksi",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFF44474E),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _pilihTanggal(context),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF1F4F7),
                      hintText: "DD-MM-YYYY",
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5C6CF),
                        ), // Warna border baru
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5C6CF),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF0050CC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Color(0XFFFFFFFF)),
                        SizedBox(width: 4.5),
                        Text(
                          "Cari Laporan",
                          style: TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: 96,
            height: 96,
            child: CircleAvatar(
              backgroundColor: const Color(0xFFEBEEF1),
              radius: 48,
              child: const Icon(
                Icons.event_busy_outlined,
                size: 40,
                color: Color(0xFF75777F),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Belum Ada Data ",
            style: TextStyle(color: Color(0XFF181C1E), fontSize: 16),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 48, right: 48, bottom: 48),
            child: Text(
              "Pilih tanggal untuk melihat laporan harian transaksi anda secara rinci.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: Intl.defaultLocale,
                color: Color(0XFF44474E),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
