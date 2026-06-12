import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sintakqu/model/transaksi_model.dart';
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
        no_hp TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        is_login INTEGER DEFAULT 0,
        status TEXT,
        foto_profil TEXT,
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

  /////////////////////query untuk aksi transaksi list//////////////////////////

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
  Future<TransaksiModel?> getTransaksiById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'transaksi',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    // Konversi hasil map dari SQLite menjadi objek TransaksiModel
    if (maps.isNotEmpty) {
      return TransaksiModel.fromMap(maps.first);
    }

    return null;
  }

  // 4. UPDATE (Perbarui Data Transaksi)
  Future<int> updateTransaksi(
    int id,
    String keterangan,
    String kategori,
    double nominal,
    String? gambarPath,
  ) async {
    final db = await database;
    return await db.update(
      'transaksi',
      {
        'keterangan': keterangan,
        'kategori': kategori,
        'nominal': nominal,
        'gambar': gambarPath,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 5. DELETE (Hapus Data Transaksi)
  Future<int> hapusTransaksi(int id) async {
    final db = await database;
    return await db.delete('transaksi', where: 'id = ?', whereArgs: [id]);
  }

  ///// query untuk aksi table user //////////////////////////////////////////

  //Registrasi akun baru
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

  //Fungsi Cek Login
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

  // Fungsi Auto-Redirect
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

  // Fungsi Logout
  Future<void> logoutUser() async {
    final db = await database;
    await db.update(
      'user_sintakqu',
      {'is_login': 0},
      where: 'is_login = ?',
      whereArgs: [1],
    );
  }

  // Ambil 1 data user
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
      if (row['periode'] == 'hari_ini') {
        hariIni = double.parse(row['total'].toString());
      }

      if (row['periode'] == 'minggu_ini') {
        mingguIni = double.parse(row['total'].toString());
      }
      if (row['periode'] == 'bulan_ini') {
        bulanIni = double.parse(row['total'].toString());
      }
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

    //   return await db.rawQuery('''
    //   SELECT
    //     date(created_at / 1000, 'unixepoch', 'localtime') AS tanggal,
    //     COALESCE(SUM(nominal), 0) AS total
    //   FROM transaksi
    //   GROUP BY tanggal
    //   ORDER BY tanggal ASC
    //   LIMIT 7
    // ''');
  }

  // laporan per bulan get total pengeluaran
  Future<double> getTotalPengeluaranBulan(int bulan) async {
    final db = await database;
    final String tahunIni = DateTime.now().year.toString();
    final String formatBulan = bulan.toString().padLeft(
      2,
      '0',
    ); // Ubah 5 jadi '05'

    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT SUM(nominal) as total 
    FROM transaksi 
    WHERE strftime('%Y', datetime(created_at / 1000, 'unixepoch', 'localtime')) = ?
      AND strftime('%m', datetime(created_at / 1000, 'unixepoch', 'localtime')) = ?
  ''',
      [tahunIni, formatBulan],
    );

    if (result.isNotEmpty && result.first['total'] != null) {
      return (result.first['total'] as num).toDouble();
    }
    return 0.0;
  }

  // laporan bulanan get total pengeluaran per bulan per kategori
  Future<List<Map<String, dynamic>>> getPengeluaranPerKategoriBulan(
    int bulan,
  ) async {
    final db = await database;
    final String tahunIni = DateTime.now().year.toString();
    final String formatBulan = bulan.toString().padLeft(2, '0');

    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT kategori, SUM(nominal) as total 
    FROM transaksi 
    WHERE strftime('%Y', datetime(created_at / 1000, 'unixepoch', 'localtime')) = ?
      AND strftime('%m', datetime(created_at / 1000, 'unixepoch', 'localtime')) = ?
    GROUP BY kategori
    ORDER BY total DESC
  ''',
      [tahunIni, formatBulan],
    );

    return result;
  }

  // laporan bulanan get trend pengeluaran per bulan
  Future<List<Map<String, dynamic>>> getTrendPengeluaranHanyaYangAda() async {
    final db = await database;
    final String tahunIni = DateTime.now().year.toString();

    // Query ini hanya mengambil bulan yang memiliki transaksi
    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT 
      strftime('%m', datetime(created_at / 1000, 'unixepoch', 'localtime')) as bulan_angka,
      SUM(nominal) as total
    FROM transaksi
    WHERE strftime('%Y', datetime(created_at / 1000, 'unixepoch', 'localtime')) = ?
    GROUP BY bulan_angka
    ORDER BY bulan_angka ASC
  ''',
      [tahunIni],
    );

    return result;
    // Output hanya bulan yang ada data, misal: [{'bulan_angka': '06', 'total': 150000.0}]
  }

  // generator untuk membuat data dummy
  Future<void> insert20DataDummyMei() async {
    final db = await database;

    // 1. DAFTAR KATEGORI SESUAI PERMINTAAN ANDA
    final List<String> kategoriList = [
      'Belanja Bulanan',
      'E-Commerce & Belanja',
      'Hiburan & Gaya Hidup',
      'Internet & Komunikasi',
      'Kesehatan',
      'Kuliner & Makanan',
      'Pendidikan',
      'Sosial & Donasi',
      'Tagihan Rumah Tangga',
      'Transportasi',
      'Lain-lain',
    ];

    // 2. KETERANGAN ACAK YANG COCOK DENGAN KATEGORI DI ATAS
    final List<String> keteranganList = [
      'Beli sembako supermarket',
      'Belanja baju di online shop',
      'Nonton bioskop & jajan',
      'Beli paket internet bulanan',
      'Beli obat dan vitamin',
      'Makan siang nasi padang',
      'Beli buku cetak kuliah',
      'Infaq dan sedekah jumat',
      'Bayar tagihan listrik air',
      'Isi saldo e-toll dan bensin',
      'Biaya admin dan parkir',
    ];

    final int tahunIni = DateTime.now().year;
    final batch = db.batch();

    for (int i = 1; i <= 20; i++) {
      // Membagi transaksi merata di sepanjang bulan Mei (tanggal 1 sampai 28)
      int tanggalAcak = (i % 10) + 1;
      int jamAcak = (i * 3) % 24;
      int menitAcak = (i * 7) % 60;

      DateTime tanggalMei = DateTime(
        tahunIni,
        6,
        tanggalAcak,
        jamAcak,
        menitAcak,
      );
      int timestampMilidetik = tanggalMei.millisecondsSinceEpoch;

      // Membuat nominal acak kelipatan Rp 5.000 (Rentang Rp 15.000 - Rp 350.000)
      double nominalAcak = ((i * 17) % 70 + 3) * 5000;

      // Mengambil indeks secara dinamis agar semua kategori kebagian data
      String kategoriPilihan = kategoriList[i % kategoriList.length];
      String keteranganPilihan =
          "${keteranganList[i % keteranganList.length]} ke-$i";

      batch.insert('transaksi', {
        'nominal': nominalAcak,
        'kategori': kategoriPilihan,
        'keterangan': keteranganPilihan,
        'gambar': null,
        'created_at': timestampMilidetik,
        'updated_at': timestampMilidetik,
      });
    }

    await batch.commit(noResult: true);
    Text(
      "Berhasil memasukkan 20 data Mei dengan kategori baru! jangal lupa di hapus fungis ini!",
    );
  }

  // delete data di tabel transaksi all (WAJIB HAPUS KALO SUDAH DI PRODUCTION)
  Future<int> deleteAllTransaksiRaw() async {
    final db = await database;

    // Mengeksekusi perintah SQL DELETE
    return await db.rawDelete('DELETE FROM transaksi');
  }

  //laporan pencarian transaksi berdasarkan input tanggal
  Future<List<Map<String, dynamic>>> cariTransaksiMulaiTanggal(
    String pilihTanggal,
  ) async {
    final db = await database;
    return await db.query(
      'transaksi',
      where: "date(created_at / 1000, 'unixepoch', 'localtime') = ?",
      whereArgs: [pilihTanggal],
      orderBy: 'created_at DESC', // Urutkan dari yang paling baru
    );
  }

  //laporan bulanan ambil data transaksi per kategori
  Future<List<Map<String, dynamic>>> getTransaksiDanTotalPerKategoriBulan(
    String kategori,
    int bulan,
  ) async {
    final db = await database;
    int tahunSekarang = DateTime.now().year;

    // Rentang waktu dalam bentuk timestamp milidetik (Epoch)
    int epochAwal = DateTime(tahunSekarang, bulan, 1).millisecondsSinceEpoch;
    int epochAkhir = DateTime(
      tahunSekarang,
      bulan + 1,
      1,
    ).subtract(const Duration(milliseconds: 1)).millisecondsSinceEpoch;

    // Menggunakan Window Function (SUM OVER) untuk menghitung total langsung di SQLite
    String query = '''
    SELECT *, 
    SUM(nominal) OVER() as total_pengeluaran_kategori
    FROM transaksi
    WHERE kategori = ? AND created_at >= ? AND created_at <= ?
    ORDER BY created_at DESC
  ''';

    return await db.rawQuery(query, [kategori, epochAwal, epochAkhir]);
  }
}
