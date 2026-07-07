class UserModel {
  final String uid;
  final String namaLengkap;
  final String email;
  final String noHp;
  final String status;
  final String? fotoProfil;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.namaLengkap,
    required this.email,
    required this.noHp,
    required this.status,
    this.fotoProfil,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      namaLengkap: map['nama_lengkap'] ?? '',
      email: map['email'] ?? '',
      noHp: map['no_hp'] ?? '',
      status: map['status'] ?? 'pending',
      fotoProfil: map['foto_profil'],
      createdAt: map['created_at']?.toDate(),
      updatedAt: map['updated_at']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_lengkap': namaLengkap,
      'email': email,
      'no_hp': noHp,
      'status': status,
      'foto_profil': fotoProfil,
    };
  }
}
