import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintakqu/services/firestore_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Registrasi User
  Future<UserCredential> register({
    required String namaLengkap,
    required String email,
    required String noHp,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    await FirestoreService().simpanUser(
      uid: uid,
      namaLengkap: namaLengkap,
      email: email,
      noHp: noHp,
    );

    return credential;
  }

  /// Login User
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Logout User
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  /// User yang sedang login
  User? get currentUser {
    return _auth.currentUser;
  }

  //reset password sintakqu
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception('Format email tidak valid.');
        case 'user-not-found':
          throw Exception('Email tidak terdaftar.');
        case 'network-request-failed':
          throw Exception('Tidak ada koneksi internet.');
        case 'too-many-requests':
          throw Exception(
            'Terlalu banyak percobaan. Silakan coba beberapa saat lagi.',
          );
        default:
          throw Exception(e.message ?? 'Terjadi kesalahan.');
      }
    } catch (_) {
      throw Exception('Terjadi kesalahan.');
    }
  }
}
