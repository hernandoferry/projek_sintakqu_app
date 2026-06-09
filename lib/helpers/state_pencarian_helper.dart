import 'package:flutter/material.dart';

class StatePencarianHelper extends StatelessWidget {
  final bool belumCari;

  const StatePencarianHelper({super.key, required this.belumCari});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                style: TextStyle(fontSize: 16, color: Color(0XFF44474E)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
