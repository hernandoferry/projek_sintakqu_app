import 'package:path/path.dart';
// 1. PENTING: Ubah sesuai lokasi/nama file model transaksi Anda yang sebenarnya
import 'package:projek_sintakqu_app/model/transaksi_model.dart';
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
        created_at INTEGER NOT NULL,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  // 1. CREATE (Tambah Transaksi Baru)
  Future<int> tambahTransaksi(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('transaksi', data);
  }

  //  READ ALL (Ambil Semua Data Transaksi)
  Future<List<Map<String, dynamic>>> ambilSemuaTransaksi() async {
    final db = await database;
    return await db.query('transaksi', orderBy: 'created_at DESC');
  }

  // Mengambil kolom tertentu, urut terbaru (DESC), batasi 2 data
  Future<List<TransaksiModel>> getDuaPengeluaranTerakhir() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT keterangan, created_at, nominal FROM transaksi ORDER BY created_at DESC LIMIT 2',
    );

    return List.generate(maps.length, (i) {
      return TransaksiModel.fromMap(maps[i]); // Memanggil dari model transaksi
    });
  }

  // Mengambil kolom tertentu, urut terbaru (DESC), batasi 20 data
  Future<List<Map<String, dynamic>>>
  getLastDuapuluhPengeluaranTerakhir() async {
    final db = await database;

    return await db.query('transaksi', orderBy: 'created_at DESC', limit: 20);
  }

  //  READ BY ID (Ambil Satu Transaksi Berdasarkan ID)
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

    List<Map<String, dynamic>> cekEmail = await db.query(
      'user_sintakqu',
      where: 'email = ?',
      whereArgs: [data['email']],
    );

    if (cekEmail.isNotEmpty) {
      return -1;
    }

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

  // 8. Fungsi Auto-Redirect
  Future<bool> cekStatusLogin() async {
    final db = await database;

    List<Map<String, dynamic>> hasil = await db.query(
      'user_sintakqu',
      where: 'is_login = ?',
      whereArgs: [1],
      limit: 1,
    );

    return hasil.isNotEmpty;
  }

  // 9. Fungsi Logout
  Future<void> logoutUser() async {
    final db = await database;
    await db.update(
      'user_sintakqu',
      {'is_login': 0},
      where: 'is_login = ?',
      whereArgs: [1],
    );
  }

  // 10. Ambil 1 data user
  Future<Map<String, dynamic>?> getDataLoggeduser() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'user_sintakqu',
      where: 'is_login = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // ambil total pengeluran hari ini,minggu ini dan bulan ini
  Future<Map<String, double>> ambilRekapPengeluaran() async {
    final db = await database; // Sesuaikan dengan variabel database Anda

    // Mengonversi miliDetik ke format tanggal SQLite menggunakan datetime(created_at/1000, 'unixepoch', 'localtime')
    final List<Map<String, dynamic>> hasil = await db.rawQuery('''
    SELECT 'hari_ini' AS periode, COALESCE(SUM(nominal), 0) AS total 
    FROM transaksi 
    WHERE date(created_at / 1000, 'unixepoch', 'localtime') = date('now', 'localtime')
    
    UNION ALL
    
    SELECT 'minggu_ini' AS periode, COALESCE(SUM(nominal), 0) AS total 
    FROM transaksi 
    WHERE date(created_at / 1000, 'unixepoch', 'localtime') >= date('now', 'localtime', 'weekday 1', '-7 days')
    
    UNION ALL
    
    SELECT 'bulan_ini' AS periode, COALESCE(SUM(nominal), 0) AS total 
    FROM transaksi 
    WHERE strftime('%Y-%m', created_at / 1000, 'unixepoch', 'localtime') = strftime('%Y-%m', 'now', 'localtime');
  ''');

    double hariIni = 0;
    double mingguIni = 0;
    double bulanIni = 0;

    for (var row in hasil) {
      if (row['periode'] == 'hari_ini')
        hariIni = double.parse(row['total'].toString());
      if (row['periode'] == 'minggu_ini')
        mingguIni = double.parse(row['total'].toString());
      if (row['periode'] == 'bulan_ini')
        bulanIni = double.parse(row['total'].toString());
    }

    return {
      'hari_ini': hariIni,
      'minggu_ini': mingguIni,
      'bulan_ini': bulanIni,
    };
  }

  //get data untuk line chart 7 hari terakhir
  Future<List<Map<String, dynamic>>> ambilStatistik7Hari() async {
    final db = await database;

    // Query mengambil data 7 hari terakhir, dikelompokkan (GROUP BY) per hari
    return await db.rawQuery('''
    SELECT 
      date(created_at / 1000, 'unixepoch', 'localtime') AS tanggal,
      COALESCE(SUM(nominal), 0) AS total
    FROM transaksi
    WHERE date(created_at / 1000, 'unixepoch', 'localtime') >= date('now', 'localtime', '-6 days')
    GROUP BY tanggal
    ORDER BY tanggal ASC
  ''');
  }
}
