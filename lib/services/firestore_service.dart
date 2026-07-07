import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintakqu/model/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> simpanUser({
    required String uid,
    required String namaLengkap,
    required String email,
    required String noHp,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'nama_lengkap': namaLengkap,
      'email': email,
      'no_hp': noHp,
      'status': 'aktif',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  //ambil data user di firestore
  Future<UserModel> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw Exception("Data user tidak ditemukan.");
    }

    return UserModel.fromMap(doc.id, doc.data()!);
  }

  //update data userfirebase
  Future<void> updateUser({
    required String uid,
    required String namaLengkap,
    required String email,
    required String noHp,
  }) async {
    await _firestore.collection('users').doc(uid).update({
      'nama_lengkap': namaLengkap,
      'email': email,
      'no_hp': noHp,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
