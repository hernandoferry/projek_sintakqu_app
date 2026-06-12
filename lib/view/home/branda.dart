import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintakqu/database/db_helper.dart';
import 'package:sintakqu/model/transaksi_model.dart';

class Branda extends StatefulWidget {
  const Branda({super.key});

  @override
  State<Branda> createState() => _BrandaState();
}

class _BrandaState extends State<Branda> {
  late Future<Map<String, dynamic>?> _ambilDataUserLogin;
  late Future<Map<String, double>> _ambilRekapPengeluaran;
  late Future<List<Map<String, dynamic>>> _ambilStatistikChart;
  bool _nominalPengeluaran = true;
  // Fungsi pembantu konversi nama bulan
  String _namaBulan(int bulan) {
    const bulanList = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Agu",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];
    return bulanList[bulan - 1];
  }

  // Menampilkan format rupiah
  String _formatRupiah(double nominal) {
    return "Rp ${nominal.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  void tampilkanPengeluaranTerakhir(BuildContext context) async {
    final dbData = await DbHelper().getLastDuapuluhPengeluaranTerakhir();
    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF1F4F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Daftar Pengeluaran Terakhir",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001A41),
                          ),
                        ),
                        Text(
                          "Terbaru",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0050CC),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF0F0F0),
                  ),
                  Expanded(
                    child: dbData.isEmpty
                        ? const Center(child: Text("Belum ada data transaksi."))
                        : ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: dbData.length,
                            itemBuilder: (context, index) {
                              final data = dbData[index];
                              final transaksi = TransaksiModel.fromMap(data);

                              String tanggalStr =
                                  "${transaksi.createdAt.day} ${_namaBulan(transaksi.createdAt.month)} ${transaksi.createdAt.year}";

                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 2,
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0x1AFF5252),
                                  radius: 20,
                                  child: Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xFFFF5252),
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  transaksi.keterangan.isEmpty
                                      ? "Tanpa Keterangan"
                                      : transaksi.keterangan,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF1F1F1F),
                                  ),
                                ),
                                subtitle: Text(
                                  "${transaksi.kategoriTrans} • $tanggalStr",
                                  style: const TextStyle(
                                    color: Color(0xFF757575),
                                    fontSize: 11,
                                  ),
                                ),
                                trailing: Text(
                                  "- ${_formatRupiah(transaksi.nilaiTransaksi)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFFBA1A1A),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _ambilDataUserLogin = DbHelper().getDataLoggeduser();
    _ambilRekapPengeluaran = DbHelper().ambilRekapPengeluaran();
    _ambilStatistikChart = DbHelper().ambilStatistik7Hari();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _ambilDataUserLogin,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Memuat...');
            }

            // Perbaikan: Tambahkan pengecekan null safety agar aplikasi tidak crash jika data kosong
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null) {
              return const Text('Gagal memuat data');
            }
            final userData = snapshot.data!;
            final String namaUser = userData['nama_lengkap'] ?? 'Pengguna';
            final String imagePath = userData['foto_profil'] ?? '';
            return Row(
              children: [
                CircleAvatar(
                  radius:
                      25, // Anda bisa mengubah ukuran lingkaran dengan mengganti nilai radius ini
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      imagePath.isNotEmpty && File(imagePath).existsSync()
                      ? FileImage(File(imagePath))
                      : const AssetImage("assets/images/user_dummy.png")
                            as ImageProvider,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 18,
                    top: 18,
                    bottom: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Text(
                          "Hallo,",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        namaUser,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.notifications_none, color: Color(0xFF0050CC)),
              ],
            );
          },
        ),

        backgroundColor: const Color(0xFFF7FAFD),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[300], height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            FutureBuilder<Map<String, double>>(
              future: _ambilRekapPengeluaran,
              builder: (context, snapshot) {
                // Tampilan indikator loading statis berukuran sama saat data memuat
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      height: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF001A41).withValues(alpha: 0.1),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                // Jika terjadi error atau data kosong, set nilai default ke 0
                final double bulanIni =
                    (snapshot.hasData && snapshot.data != null)
                    ? snapshot.data!['bulan_ini'] ?? 0.0
                    : 0.0;
                final double mingguIni =
                    (snapshot.hasData && snapshot.data != null)
                    ? snapshot.data!['minggu_ini'] ?? 0.0
                    : 0.0;

                final double hariIni =
                    (snapshot.hasData && snapshot.data != null)
                    ? snapshot.data!['hari_ini'] ?? 0.0
                    : 0.0;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF001A41), Color(0xFF0050CC)],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total Pengeluaran Bulan Ini",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(
                                        0xFFFFFFFF,
                                      ).withValues(alpha: 0.6),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    _nominalPengeluaran
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _nominalPengeluaran =
                                          !_nominalPengeluaran;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Text(
                              _nominalPengeluaran
                                  ? 'Rp ••••••••••••'
                                  : _formatRupiah(bulanIni),
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x1AFFFFFF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFFFDCC3),
                                    radius: 8,
                                    child: Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFF0050CC),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Membership Level : Standard",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFDCC3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 19.33),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    "Pengeluaran hari ini",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF44474E),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    _nominalPengeluaran
                                        ? 'Rp ••••'
                                        : _formatRupiah(hariIni),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Color(0xFF0050CC),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              width: 170.5,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC07024),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(14),
                                  bottomRight: Radius.circular(12),
                                  topLeft: Radius.circular(14),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(left: 5),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(9),
                                  topLeft: Radius.circular(9),
                                  bottomRight: Radius.circular(12),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      Row(
                                        children: const [
                                          SizedBox(width: 16),
                                          Icon(
                                            Icons.loyalty,
                                            color: Color(0xFFC07024),
                                            size: 13.32,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Minggu ini',
                                            style: TextStyle(
                                              color: Color(0xFFC07024),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      const Spacer(),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                        ),
                                        child: Text(
                                          _nominalPengeluaran
                                              ? 'Rp ••••'
                                              : _formatRupiah(mingguIni),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFC07024),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Statistik Pengeluaran",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0XFF181C1E),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0050CC),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.only(left: 2, right: 16),
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _ambilStatistikChart,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final dataChart = snapshot.data ?? [];
                        List<FlSpot> spots = [];
                        List<String> labelTanggal = [];

                        // Jika data database kosong (misal pengguna baru), isi titik default 0 agar tidak error
                        if (dataChart.isEmpty) {
                          spots = const [
                            FlSpot(0, 0),
                            FlSpot(1, 0),
                            FlSpot(2, 0),
                          ];
                          labelTanggal = const ["-", "-", "-"];
                        } else {
                          // Memetakan data dari database ke titik koordinat grafik (X = Hari ke-sekian, Y = Jumlah Uang)
                          for (int i = 0; i < dataChart.length; i++) {
                            double total = double.parse(
                              dataChart[i]['total'].toString(),
                            );
                            spots.add(FlSpot(i.toDouble(), total));

                            // Memotong format teks tanggal YYYY-MM-DD menjadi MM-DD (Contoh: 06-08) agar muat di layar
                            String tglFull = dataChart[i]['tanggal'] ?? "";
                            String tglShort = tglFull.length > 5
                                ? tglFull.substring(5)
                                : tglFull;
                            labelTanggal.add(tglShort);
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            height: 220,
                            padding: const EdgeInsets.only(
                              left: 4,
                              right: 8,
                              top: 16,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: LineChart(
                              LineChartData(
                                minX: 0,
                                maxX: labelTanggal.isEmpty
                                    ? 0
                                    : (labelTanggal.length - 1).toDouble(),

                                lineTouchData: LineTouchData(
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipColor: (touchedSpot) =>
                                        const Color(
                                          0xFF001A41,
                                        ).withValues(alpha: 0.7),
                                    tooltipBorderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                    getTooltipItems:
                                        (List<LineBarSpot> touchedSpots) {
                                          return touchedSpots.map((barSpot) {
                                            return LineTooltipItem(
                                              _formatRupiah(barSpot.y),
                                              const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            );
                                          }).toList();
                                        },
                                  ),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  getDrawingHorizontalLine: (value) => FlLine(
                                    color: const Color(0xFFF0F0F0),
                                    strokeWidth: 1,
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),

                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      reservedSize: 30,
                                      getTitlesWidget: (value, meta) {
                                        int index = value.toInt();
                                        if (index >= 0 &&
                                            index < labelTanggal.length) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              labelTanggal[index],
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF757575),
                                              ),
                                            ),
                                          );
                                        }
                                        return const Text('');
                                      },
                                    ),
                                  ),

                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 45,
                                      getTitlesWidget: (value, meta) {
                                        if (value >= 1000000) {
                                          return Text(
                                            '${(value / 1000000).toStringAsFixed(1)}M',
                                            style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey,
                                            ),
                                          );
                                        } else if (value >= 1000) {
                                          return Text(
                                            '${(value / 1000).toStringAsFixed(0)}K',
                                            style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey,
                                            ),
                                          );
                                        }
                                        return Text(
                                          value.toStringAsFixed(0),
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: spots,
                                    isCurved: true,
                                    color: const Color(0xFF0050CC),
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: const FlDotData(show: true),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: const Color(
                                        0xFF0050CC,
                                      ).withValues(alpha: 0.3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0XFFF1F4F7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        tampilkanPengeluaranTerakhir(context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              right: 20,
                              bottom: 5,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.history, color: Color(0XFF0050CC)),
                                SizedBox(width: 8),
                                Text(
                                  "Daftar Pengeluaran Terakhir",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color(0XFF181C1E),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          FutureBuilder<List<TransaksiModel>>(
                            future: DbHelper().getDuaPengeluaranTerakhir(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text("Belum ada data transaksi."),
                                );
                              }

                              final listTransaksi = snapshot.data!;

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listTransaksi.length,
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey[400],
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                itemBuilder: (context, index) {
                                  final transaksi = listTransaksi[index];

                                  // Format Tanggal (Contoh hasil: 11 Okt 2026)
                                  String tanggalFormat =
                                      "${transaksi.createdAt.day} "
                                      "${_namaBulan(transaksi.createdAt.month)} "
                                      "${transaksi.createdAt.year}";

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      top: 10,
                                      right: 21,
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_basket,
                                          color: Color(0xFF0050CC),
                                        ),
                                        const SizedBox(width: 12),

                                        // 💡 1. Bungkus Column ini dengan Expanded agar tahu batas maksimal lebar layar
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                transaksi.keterangan.length > 25
                                                    ? '${transaksi.keterangan.substring(0, 22)}...'
                                                    : transaksi.keterangan,
                                                // 💡 2. Tambahkan properti ini agar teks memotong rapi jika masih mentok
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                tanggalFormat,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 💡 3. Ganti Spacer() dengan SizedBox jika menggunakan Expanded di atas
                                        // agar nominal uang terdorong rapi tanpa merusak layout
                                        const SizedBox(width: 16),

                                        Text(
                                          "- Rp ${transaksi.nilaiTransaksi.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFFBA1A1A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
