import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportPdfService {
  static Future<File> generatePdf(
    List<Map<String, dynamic>> data,
    String namaBulan,
  ) async {
    final pdf = pw.Document();
    final rupiahFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    double total = 0;

    for (var item in data) {
      total += (item['nominal'] as num).toDouble();
    }
    pw.Widget headerCell(String text) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(8),
        color: PdfColors.grey300,
        child: pw.Text(
          text,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
      );
    }

    pw.Widget dataCell(String text) {
      return pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        child: pw.Text(text),
      );
    }

    final ByteData logoData = await rootBundle.load(
      'assets/images/icon_dompet.png',
    );

    final Uint8List logoBytes = logoData.buffer.asUint8List();

    final logo = pw.MemoryImage(logoBytes);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Center(
            child: pw.Column(
              children: [
                pw.Image(logo, width: 100, height: 100),
                pw.SizedBox(height: 8),
                pw.Text(
                  'SintakQu',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Text(
                  'Laporan Pengeluaran Bulan $namaBulan',
                  style: const pw.TextStyle(fontSize: 12),
                ),

                pw.Text(
                  'Dicetak pada tanggal: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 15),
          pw.Divider(),
          pw.Table(
            border: pw.TableBorder.all(),

            columnWidths: {
              0: const pw.FixedColumnWidth(40), // No
              1: const pw.FixedColumnWidth(80),
              2: const pw.FixedColumnWidth(100),
              3: const pw.FixedColumnWidth(100),
            },
            children: [
              pw.TableRow(
                children: [
                  headerCell('No'),
                  headerCell('Tanggal'),
                  headerCell('Kategori'),
                  headerCell('Nominal'),
                  headerCell('Catatan'),
                ],
              ),

              ...data.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                final tanggal = DateTime.fromMillisecondsSinceEpoch(
                  item['created_at'] as int,
                );

                return pw.TableRow(
                  children: [
                    dataCell('${index + 1}'),
                    dataCell('${tanggal.day}/${tanggal.month}/${tanggal.year}'),
                    dataCell(item['kategori'].toString()),
                    dataCell(rupiahFormat.format(item['nominal'])),
                    dataCell(item['keterangan']?.toString() ?? '-'),
                  ],
                );
              }),
            ],
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            'Total Pengeluaran : ${rupiahFormat.format(total)}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/laporan_$namaBulan.pdf');

    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
