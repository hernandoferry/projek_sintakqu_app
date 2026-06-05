import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  factory DbHelper() => _instance;

  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sintakqu_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Membuat banyak tabel sekaligus di dalam fungsi _onCreate
  Future _onCreate(Database db, int version) async {
    // 1. Pembuatan Table User
    await db.execute('''
      CREATE TABLE user_sintakqu (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_lengkap TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        no_hp TEXT,
        password TEXT NOT NULL,
        is_login INTEGER DEFAULT 0,
        status TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // 2. Pembuatan Table Transaksi
    await db.execute('''
      CREATE TABLE transaksi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nominal REAL NOT NULL,
        kategori TEXT NOT NULL,
        keterangan TEXT,
        gambar TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  // 1. CREATE (Tambah Transaksi Baru)
  Future<int> tambahTransaksi(Map<String, dynamic> data) async {
    final db = await database;
    // Fungsi insert mengembalikan ID dari baris data yang baru dibuat
    return await db.insert('transaksi', data);
  }

  // 2. READ ALL (Ambil Semua Data Transaksi)
  Future<List<Map<String, dynamic>>> ambilSemuaTransaksi() async {
    final db = await database;
    // Mengurutkan berdasarkan tanggal terbaru (created_at DESC)
    return await db.query('transaksi', orderBy: 'created_at DESC');
  }

  // 3. READ BY ID (Ambil Satu Transaksi Berdasarkan ID)
  Future<Map<String, dynamic>?> ambilTransaksiById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> hasil = await db.query(
      'transaksi',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (hasil.isNotEmpty) {
      return hasil.first;
    }
    return null;
  }

  // 4. UPDATE (Perbarui Data Transaksi)
  Future<int> ubahTransaksi(int id, Map<String, dynamic> data) async {
    final db = await database;

    // Perbarui kolom updated_at dengan waktu saat ini
    data['updated_at'] = DateTime.now().toIso8601String();

    return await db.update('transaksi', data, where: 'id = ?', whereArgs: [id]);
  }

  // 5. DELETE (Hapus Data Transaksi)
  Future<int> hapusTransaksi(int id) async {
    final db = await database;
    return await db.delete('transaksi', where: 'id = ?', whereArgs: [id]);
  }

  // 6. Fungsi Registrasi Akun Baru
  Future<int> registrasiUser(Map<String, dynamic> data) async {
    final db = await database;

    // Pastikan email belum terdaftar sebelum memasukkan data baru
    List<Map<String, dynamic>> cekEmail = await db.query(
      'user_sintakqu',
      where: 'email = ?',
      whereArgs: [data['email']],
    );

    if (cekEmail.isNotEmpty) {
      // Mengembalikan nilai -1 sebagai penanda kalau email sudah terdaftar
      return -1;
    }

    // Jika email aman, masukkan data ke tabel user
    return await db.insert('user_sintakqu', data);
  }

  // 7. Fungsi Cek Login
  Future<bool> cekLogin(String email, String password) async {
    final db = await database;

    List<Map<String, dynamic>> hasil = await db.query(
      'user_sintakqu',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (hasil.isNotEmpty) {
      // Jika akun cocok, ubah status 'is_login' menjadi 1 (true) untuk sesi otomatis
      int userId = hasil.first['id'];
      await db.update(
        'user_sintakqu',
        {'is_login': 1},
        where: 'id = ?',
        whereArgs: [userId],
      );
      return true;
    }
    return false;
  }

  // 8. Fungsi Auto-Redirect (Cek apakah ada user yang status is_login = 1)
  Future<bool> cekStatusLogin() async {
    final db = await database;

    List<Map<String, dynamic>> hasil = await db.query(
      'user_sintakqu',
      where: 'is_login = ?',
      whereArgs: [1], // Mencari user yang sedang aktif login
    );

    return hasil.isNotEmpty;
  }

  // 9. Fungsi Logout (Opsional - untuk mengubah status is_login kembali ke 0)
  Future<void> logoutUser() async {
    final db = await database;
    await db.update(
      'user_sintakqu',
      {'is_login': 0},
      where: 'is_login = ?',
      whereArgs: [1],
    );
  }
}
