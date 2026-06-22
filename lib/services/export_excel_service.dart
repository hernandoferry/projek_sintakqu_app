import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExportExcelService {
  static Future<File> generateExcel(
    List<Map<String, dynamic>> data,
    String namaBulan,
  ) async {
    var excel = Excel.createExcel();

    Sheet sheet = excel['Laporan'];

    sheet.appendRow([
      TextCellValue("Tanggal"),
      TextCellValue("Kategori"),
      TextCellValue("Nominal"),
      TextCellValue("Catatan"),
    ]);

    double total = 0;

    for (var item in data) {
      total += (item['nominal'] as num).toDouble();

      sheet.appendRow([
        TextCellValue(item['created_at'].toString()),
        TextCellValue(item['kategori'].toString()),
        DoubleCellValue((item['nominal'] as num).toDouble()),
        TextCellValue(item['keterangan'] ?? '-'),
      ]);
    }

    sheet.appendRow([]);

    sheet.appendRow([
      TextCellValue("TOTAL"),
      TextCellValue(""),
      DoubleCellValue(total),
      TextCellValue(""),
    ]);

    final dir = await getExternalStorageDirectory();

    final laporanDir = Directory('${dir!.path}/Laporan_sintakQu');

    if (!await laporanDir.exists()) {
      await laporanDir.create(recursive: true);
    }

    final file = File('${laporanDir.path}/SintakQu_Laporan_$namaBulan.xlsx');

    return file;
  }
}
