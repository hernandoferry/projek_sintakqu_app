import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/database/db_helper.dart';
import 'package:projek_sintakqu_app/view/laporan/detail_kategori_laporan.dart';

class BulananLaporan extends StatefulWidget {
  const BulananLaporan({super.key});

  @override
  State<BulananLaporan> createState() => _BulananLaporanState();
}

class _BulananLaporanState extends State<BulananLaporan> {
  // set controller untuk mengendalikan posisi scroll nama bulan
  final ScrollController _scrollController = ScrollController();

  // set nama bulan lengkap
  final List<String> semuaBulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  List<String> get daftarBulanTersedia {
    int bulanSekarang = DateTime.now().month; // Mengembalikan angka 1-12
    return semuaBulan.sublist(0, bulanSekarang);
  }

  int bulanTerpilih = 0;

  @override
  void initState() {
    super.initState();
    // Set awal pilihan ke bulan paling terakhir (terbaru)
    bulanTerpilih = daftarBulanTersedia.length - 1;

    // Jalankan auto-scroll tepat setelah halaman selesai dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jalankanAutoScroll();
    });
  }

  void _jalankanAutoScroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Variabel helper untuk visual grafik di sumbu X dan penentuan highlight warna batang aktif
    final List<String> namaBulanSingkat = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final String bulanSekarangString = DateTime.now().month.toString().padLeft(
      2,
      '0',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Bulanan"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // 1. HORIZONTAL MONTH SELECTOR
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: daftarBulanTersedia.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = index == bulanTerpilih;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          bulanTerpilih = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0XFF0050CC)
                              : const Color(0xFFEBEEF1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            daftarBulanTersedia[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            FutureBuilder<List<double>>(
              // ✨ Mengambil 2 data sekaligus: [Bulan Ini, Bulan Lalu]
              future: Future.wait([
                DbHelper().getTotalPengeluaranBulan(bulanTerpilih + 1),
                DbHelper().getTotalPengeluaranBulan(
                  bulanTerpilih,
                ), // Bulan lalu (tanpa +1)
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Memecah hasil list data snapshot
                final data = snapshot.data ?? [0.0, 0.0];
                final totalBulanIni = data[0];
                final totalBulanLalu = data[1];

                // ✨ LOGIKA PERHITUNGAN DINAMIS
                String teksPerbandingan = "";
                IconData ikonTren = Icons.trending_flat;
                Color warnaIkon = Colors.white;

                if (totalBulanLalu == 0 && totalBulanIni > 0) {
                  // Antisipasi jika bulan lalu kosong agar tidak terjadi error pembagian dengan 0 (infinity)
                  teksPerbandingan = "Langkah kecil menuju bebas finansial.";
                  ikonTren = Icons.trending_up;
                  warnaIkon = const Color(0XFFE4D329); // Kuning/Oranye
                } else if (totalBulanLalu == 0 && totalBulanIni == 0) {
                  teksPerbandingan = "Sama dengan bulan lalu";
                  ikonTren = Icons.trending_flat;
                  warnaIkon = Colors.white;
                } else {
                  // Hitung selisih persentase
                  double selisihPersen =
                      ((totalBulanIni - totalBulanLalu) / totalBulanLalu) * 100;

                  if (selisihPersen > 0) {
                    teksPerbandingan =
                        "${selisihPersen.toStringAsFixed(0)}% lebih tinggi dibanding bulan lalu";
                    ikonTren = Icons.trending_up;
                    warnaIkon = const Color(
                      0XFFE4D329,
                    ); // Naik -> Kuning peringatan
                  } else if (selisihPersen < 0) {
                    // Gunakan .abs() agar nilai minusnya hilang (misal -12% menjadi 12% penghematan)
                    teksPerbandingan =
                        "${selisihPersen.abs().toStringAsFixed(0)}% lebih hemat dibanding bulan lalu";
                    ikonTren = Icons.trending_down;
                    warnaIkon = const Color(0xFF66BB6A); // Hemat -> Hijau segar
                  } else {
                    teksPerbandingan = "Sama dengan bulan lalu";
                    ikonTren = Icons.trending_flat;
                    warnaIkon = Colors.white;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0050CC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "TOTAL PENGELUARAN BULAN INI",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${totalBulanIni.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 6),

                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 12,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    ikonTren, // Berganti otomatis naik/turun/datar
                                    color:
                                        warnaIkon, // Warna dinamis (kuning/hijau/putih)
                                    size: 14,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    teksPerbandingan, // Teks dinamis hasil kalkulasi
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Tren Pengeluaran Bulanan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
            ),

            // 3. BAR CHART DINAMIS (Aman dari Overflow dengan batasan Tinggi)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 180,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: DbHelper().getTrendPengeluaranHanyaYangAda(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final List<Map<String, dynamic>> dataList =
                        snapshot.data ?? [];

                    if (dataList.isEmpty) {
                      return const Center(
                        child: Text(
                          'Belum ada tren data transaksi di tahun ini.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    double tertinggi = 0.0;
                    for (var row in dataList) {
                      double total = (row['total'] as num).toDouble();
                      if (total > tertinggi) tertinggi = total;
                    }
                    double dinamisMaxY = tertinggi == 0
                        ? 100.0
                        : tertinggi * 1.2;

                    return BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: dinamisMaxY,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (group) => const Color(0xFF1A1A1A),
                            tooltipBorderRadius: BorderRadius.circular(8),
                            tooltipPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            tooltipMargin: 4,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              int nomorBulan = int.parse(
                                dataList[group.x]['bulan_angka'].toString(),
                              );
                              String namaBulan =
                                  namaBulanSingkat[nomorBulan - 1];
                              String formatRupiah = rod.toY
                                  .toStringAsFixed(0)
                                  .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]}.',
                                  );
                              return BarTooltipItem(
                                "$namaBulan\nRp $formatRupiah",
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              // HAPUS parameter meta jika versi lama Anda menolaknya
                              getTitlesWidget: (double value, TitleMeta meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < dataList.length) {
                                  int nomorBulan = int.parse(
                                    dataList[index]['bulan_angka'].toString(),
                                  );

                                  // Gunakan Padding biasa sebagai pengganti SideTitleWidget
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      namaBulanSingkat[nomorBulan - 1],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(dataList.length, (index) {
                          final row = dataList[index];
                          final total = (row['total'] as num).toDouble();
                          final String bulanAngka = row['bulan_angka']
                              .toString();
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: total,
                                color: bulanAngka == bulanSekarangString
                                    ? const Color(0XFF0050CC)
                                    : const Color(0X4D0050CC),
                                width: 16,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Kategori Pengeluaran",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
            ),
            SizedBox(height: 4),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: DbHelper().getPengeluaranPerKategoriBulan(
                bulanTerpilih + 1,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final List<Map<String, dynamic>> dataKategoriReal =
                    snapshot.data ?? [];
                if (dataKategoriReal.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'Tidak ada rincian pengeluaran kategori.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                double totalSemuaKategori = 0;
                for (var item in dataKategoriReal) {
                  totalSemuaKategori += (item['total'] as num).toDouble();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataKategoriReal.length,
                  itemBuilder: (context, index) {
                    final item = dataKategoriReal[index];
                    final String namaKategori = item['kategori'].toString();
                    final double nominalReal = (item['total'] as num)
                        .toDouble();
                    double progressNilai = totalSemuaKategori > 0
                        ? nominalReal / totalSemuaKategori
                        : 0.0;
                    String formatRupiah = nominalReal
                        .toStringAsFixed(0)
                        .replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]}.',
                        );

                    IconData dapatkanIkonKategori(String kategori) {
                      switch (kategori) {
                        case 'Belanja Bulanan':
                          return Icons.shopping_basket;
                        case 'E-Commerce & Belanja':
                          return Icons.shopping_bag;
                        case 'Hiburan & Gaya Hidup':
                          return Icons.movie;
                        case 'Internet & Komunikasi':
                          return Icons.language;
                        case 'Kesehatan':
                          return Icons.local_hospital;
                        case 'Kuliner & Makanan':
                          return Icons.restaurant;
                        case 'Pendidikan':
                          return Icons.school;
                        case 'Sosial & Donasi':
                          return Icons.volunteer_activism;
                        case 'Tagihan Rumah Tangga':
                          return Icons.electric_bolt;
                        case 'Transportasi':
                          return Icons.directions_car;
                        default:
                          return Icons.wallet;
                      }
                    }

                    // ✨ DI SINI TEMPAT TERBAIK UNTUK MENAMBAHKAN INKWELL
                    return Material(
                      color: Colors
                          .transparent, // Menjaga latar belakang widget tetap bersih
                      child: InkWell(
                        onTap: () {
                          // Pindah ke halaman detail sambil membawa data kategori dan bulan terpilih
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailKategoriLaporan(
                                namaKategori: namaKategori,
                                bulanAngka: bulanTerpilih + 1,
                                namaBulan: daftarBulanTersedia[bulanTerpilih],
                              ),
                            ),
                          );
                        },
                        splashColor: const Color(0XFF0050CC).withAlpha(30),
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: const Color(0XFF0050CC),
                                    child: Icon(
                                      dapatkanIkonKategori(namaKategori),
                                      color: const Color(0xFFFFFFFF),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          namaKategori,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF212121),
                                          ),
                                        ),
                                        Text(
                                          "Rp $formatRupiah",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0050CC),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: progressNilai,
                                  minHeight: 8,
                                  backgroundColor: const Color(0xFFEBEEF1),
                                  valueColor: const AlwaysStoppedAnimation(
                                    Color(0XFF0050CC),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
