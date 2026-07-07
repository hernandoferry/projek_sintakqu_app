import 'package:cloud_firestore/cloud_firestore.dart';

class TransaksiCloudModel {
  final String id;
  final double nilaiTransaksi;
  final String kategoriTrans;
  final String keterangan;
  final String? fotoStruk;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransaksiCloudModel({
    required this.id,
    required this.nilaiTransaksi,
    required this.kategoriTrans,
    required this.keterangan,
    this.fotoStruk,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransaksiCloudModel.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return TransaksiCloudModel(
      id: id,
      nilaiTransaksi: (data['nominal'] as num).toDouble(),
      kategoriTrans: data['kategori'] ?? '',
      keterangan: data['keterangan'] ?? '',
      fotoStruk: data['gambar'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }
}
