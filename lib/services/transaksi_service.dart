import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sintakqu/model/transaksi_cloud_model.dart';
import 'package:sintakqu/model/transaksi_model.dart';

class TransaksiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _transaksiRef {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User belum login.");
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('transactions');
  }

  //methode untuk simpan data transaksi baru
  Future<void> tambahTransaksi(TransaksiModel transaksi) async {
    await _transaksiRef.add({
      'nominal': transaksi.nilaiTransaksi,
      'kategori': transaksi.kategoriTrans,
      'keterangan': transaksi.keterangan,
      'gambar': transaksi.fotoStruk,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<List<TransaksiCloudModel>> getSemuaTransaksi() async {
    final snapshot = await _transaksiRef
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return TransaksiCloudModel.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  Future<List<TransaksiCloudModel>> getDuaTransaksiTerakhir() async {
    final snapshot = await _transaksiRef
        .orderBy('created_at', descending: true)
        .limit(2)
        .get();

    return snapshot.docs.map((doc) {
      return TransaksiCloudModel.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  Future<List<TransaksiCloudModel>> get20TransaksiTerakhir() async {
    final snapshot = await _transaksiRef
        .orderBy('created_at', descending: true)
        .limit(20)
        .get();

    return snapshot.docs.map((doc) {
      return TransaksiCloudModel.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  Future<Map<String, double>> ambilRekapPengeluaran() async {
    final snapshot = await _transaksiRef.get();

    final now = DateTime.now();

    double hariIni = 0;
    double mingguIni = 0;
    double bulanIni = 0;

    final awalMinggu = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));

    final akhirMinggu = awalMinggu.add(const Duration(days: 7));

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final nominal = (data['nominal'] as num).toDouble();
      final createdAt = (data['created_at'] as Timestamp).toDate();

      // Hari ini
      if (createdAt.day == now.day &&
          createdAt.month == now.month &&
          createdAt.year == now.year) {
        hariIni += nominal;
      }

      // Bulan ini
      if (createdAt.month == now.month && createdAt.year == now.year) {
        bulanIni += nominal;
      }

      // Minggu ini
      if (createdAt.isAfter(
            awalMinggu.subtract(const Duration(milliseconds: 1)),
          ) &&
          createdAt.isBefore(akhirMinggu)) {
        mingguIni += nominal;
      }
    }

    return {
      'hari_ini': hariIni,
      'minggu_ini': mingguIni,
      'bulan_ini': bulanIni,
    };
  }

  Future<List<Map<String, dynamic>>> ambilStatistik7Hari() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final now = DateTime.now();

    final awal = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 6));

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(awal))
        .orderBy('created_at')
        .get();

    debugPrint("Jumlah transaksi: ${snapshot.docs.length}");

    /// Menyiapkan 7 hari terakhir dengan nilai awal 0
    final Map<String, double> statistik = {};

    for (int i = 0; i < 7; i++) {
      final tanggal = awal.add(Duration(days: i));

      final key =
          "${tanggal.year}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}";

      statistik[key] = 0;
    }

    /// Mengisi nominal transaksi
    for (final doc in snapshot.docs) {
      final data = doc.data();

      debugPrint(data.toString());
      final createdAt = (data['created_at'] as Timestamp).toDate();

      final nominal = (data['nominal'] as num).toDouble();

      debugPrint("Tanggal : $createdAt");
      debugPrint("Nominal : $nominal");

      final key =
          "${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}";

      statistik[key] =
          (statistik[key] ?? 0) + (data['nominal'] as num).toDouble();
    }

    return statistik.entries
        .map((e) => {'tanggal': e.key, 'total': e.value})
        .toList();
  }

  Future<List<TransaksiCloudModel>> cariTransaksiByTanggal(
    DateTime tanggal,
  ) async {
    final awalHari = DateTime(tanggal.year, tanggal.month, tanggal.day);

    final akhirHari = awalHari.add(const Duration(days: 1));

    final snapshot = await _transaksiRef
        .where(
          'created_at',
          isGreaterThanOrEqualTo: Timestamp.fromDate(awalHari),
        )
        .where('created_at', isLessThan: Timestamp.fromDate(akhirHari))
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs
        .map((e) => TransaksiCloudModel.fromFirestore(e.id, e.data()))
        .toList();
  }

  Future<void> updateTransaksi({
    required String id,
    required String keterangan,
    required String kategori,
    required double nominal,
    String? gambar,
  }) async {
    await _transaksiRef.doc(id).update({
      'keterangan': keterangan,
      'kategori': kategori,
      'nominal': nominal,
      'gambar': gambar,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> hapusTransaksi(String id) async {
    await _transaksiRef.doc(id).delete();
  }

  Future<double> getTotalPengeluaranBulan(int bulan) async {
    final snapshot = await _transaksiRef.get();

    final now = DateTime.now();

    double total = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final createdAt = (data['created_at'] as Timestamp).toDate();

      if (createdAt.year == now.year && createdAt.month == bulan) {
        total += (data['nominal'] as num).toDouble();
      }
    }

    return total;
  }

  Future<List<Map<String, dynamic>>> ambilStatistikBulanan() async {
    final snapshot = await _transaksiRef.get();

    final now = DateTime.now();

    final Map<int, double> statistik = {};

    // siapkan 12 bulan = 0
    for (int i = 1; i <= 12; i++) {
      statistik[i] = 0;
    }

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final createdAt = (data['created_at'] as Timestamp).toDate();

      // hanya tahun ini
      if (createdAt.year == now.year) {
        final nominal = (data['nominal'] as num).toDouble();

        statistik[createdAt.month] =
            (statistik[createdAt.month] ?? 0) + nominal;
      }
    }

    return statistik.entries
        .map((e) => {'bulan': e.key, 'total': e.value})
        .toList();
  }

  Future<List<TransaksiCloudModel>> getLaporanBulanan(int bulan) async {
    final user = FirebaseAuth.instance.currentUser!;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs
        .map((e) => TransaksiCloudModel.fromFirestore(e.id, e.data()))
        .where((e) => e.createdAt.month == bulan)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getTrendPengeluaranHanyaYangAda() async {
    final now = DateTime.now();

    final snapshot = await _transaksiRef.get();

    final Map<int, double> dataBulanan = {};
    for (int i = 1; i <= 12; i++) {
      dataBulanan[i] = 0;
    }

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final createdAt = (data['created_at'] as Timestamp).toDate();

      // hanya tahun ini
      if (createdAt.year != now.year) continue;

      final nominal = (data['nominal'] as num).toDouble();

      dataBulanan.update(createdAt.month, (value) => value + nominal);
    }

    final hasil = dataBulanan.entries
        .map((e) => {'bulan_angka': e.key, 'total': e.value})
        .toList();

    hasil.sort(
      (a, b) => (a['bulan_angka'] as int).compareTo(b['bulan_angka'] as int),
    );

    return hasil;
  }

  Future<List<Map<String, dynamic>>> getPengeluaranPerKategoriBulan(
    int bulan,
  ) async {
    final now = DateTime.now();

    final awal = DateTime(now.year, bulan, 1);

    final akhir = bulan == 12
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, bulan + 1, 1);

    final snapshot = await _transaksiRef
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(awal))
        .where('created_at', isLessThan: Timestamp.fromDate(akhir))
        .get();

    final Map<String, double> kategori = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final namaKategori = data['kategori'] ?? 'Lainnya';
      final nominal = (data['nominal'] as num).toDouble();

      kategori[namaKategori] = (kategori[namaKategori] ?? 0) + nominal;
    }

    return kategori.entries.map((e) {
      return {'kategori': e.key, 'total': e.value};
    }).toList();
  }

  Future<List<TransaksiCloudModel>> getDetailKategoriLaporan(
    String kategori,
    int bulan,
  ) async {
    final now = DateTime.now();

    final awal = DateTime(now.year, bulan, 1);

    final akhir = bulan == 12
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, bulan + 1, 1);

    // <-- TAMBAHKAN DI SINI
    debugPrint("===== DETAIL KATEGORI =====");
    debugPrint("Kategori : $kategori");
    debugPrint("Bulan    : $bulan");
    debugPrint("Awal     : $awal");
    debugPrint("Akhir    : $akhir");

    final snapshot = await _transaksiRef
        .where('kategori', isEqualTo: kategori)
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(awal))
        .where('created_at', isLessThan: Timestamp.fromDate(akhir))
        .orderBy('created_at', descending: true)
        .get();

    // <-- TAMBAHKAN JUGA DI SINI
    debugPrint("Jumlah data : ${snapshot.docs.length}");

    for (final doc in snapshot.docs) {
      debugPrint(doc.data().toString());
    }

    return snapshot.docs
        .map((doc) => TransaksiCloudModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<TransaksiCloudModel?> getTransaksiById(String id) async {
    final doc = await _transaksiRef.doc(id).get();

    if (!doc.exists) return null;

    return TransaksiCloudModel.fromFirestore(doc.id, doc.data()!);
  }

  Future<double> getTotalPengeluaranTahunan() async {
    final now = DateTime.now();

    final awalTahun = DateTime(now.year, 1, 1);
    final akhirTahun = DateTime(now.year + 1, 1, 1);

    final snapshot = await _transaksiRef
        .where(
          'created_at',
          isGreaterThanOrEqualTo: Timestamp.fromDate(awalTahun),
        )
        .where('created_at', isLessThan: Timestamp.fromDate(akhirTahun))
        .get();

    double total = 0;

    for (final doc in snapshot.docs) {
      total += (doc['nominal'] as num).toDouble();
    }

    return total;
  }

  Future<List<Map<String, dynamic>>> getTrendPengeluaranTahunan() async {
    final snapshot = await _transaksiRef.get();

    final Map<int, double> dataTahunan = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      if (data['created_at'] == null) continue;

      final createdAt = (data['created_at'] as Timestamp).toDate();

      final tahun = createdAt.year;

      final nominal = (data['nominal'] as num).toDouble();

      dataTahunan.update(
        tahun,
        (value) => value + nominal,
        ifAbsent: () => nominal,
      );
    }

    final hasil = dataTahunan.entries
        .map((e) => {'tahun': e.key, 'total': e.value})
        .toList();

    hasil.sort((a, b) => (a['tahun'] as int).compareTo(b['tahun'] as int));

    return hasil;
  }
}
