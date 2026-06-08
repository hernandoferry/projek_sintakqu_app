// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransaksiModel {
  final int? id;
  final double nilaiTransaksi;
  final String kategoriTrans;
  final String keterangan;
  final String? fotoStruk;
  final DateTime createdAt;
  final DateTime updatedAt;
  TransaksiModel({
    this.id,
    required this.nilaiTransaksi,
    required this.kategoriTrans,
    required this.keterangan,
    this.fotoStruk,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nominal': nilaiTransaksi,
      'kategori': kategoriTrans,
      'keterangan': keterangan,
      'gambar': fotoStruk,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory TransaksiModel.fromMap(Map<String, dynamic> map) {
    // Solusi parsing aman untuk kolom updated_at yang bertipe TEXT di SQLite
    DateTime parsedUpdatedAt;
    if (map['updated_at'] is int) {
      parsedUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
        map['updated_at'] as int,
      );
    } else if (map['updated_at'] is String) {
      parsedUpdatedAt =
          DateTime.tryParse(map['updated_at'] as String) ?? DateTime.now();
    } else {
      parsedUpdatedAt = DateTime.now();
    }

    return TransaksiModel(
      id: map['id'] != null ? map['id'] as int : null,
      nilaiTransaksi: map['nominal'] != null
          ? (map['nominal'] as num).toDouble()
          : 0.0,
      kategoriTrans: map['kategori'] != null ? map['kategori'] as String : '',
      keterangan: map['keterangan'] != null ? map['keterangan'] as String : '',
      fotoStruk: map['gambar'] != null ? map['gambar'] as String : null,

      // Mengecek tipe data created_at (apabila menggunakan rawQuery kolom tertentu)
      createdAt: map['created_at'] != null
          ? (map['created_at'] is int
                ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
                : DateTime.tryParse(map['created_at'].toString()) ??
                      DateTime.now())
          : DateTime.now(),

      updatedAt: parsedUpdatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransaksiModel.fromJson(String source) =>
      TransaksiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
