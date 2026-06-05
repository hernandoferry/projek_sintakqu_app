import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projek_sintakqu_app/view/laporan/detail_kategori_laporan.dart';

class BulananLaporan extends StatefulWidget {
  const BulananLaporan({super.key});

  @override
  _BulananLaporanState createState() => _BulananLaporanState();
}

class _BulananLaporanState extends State<BulananLaporan> {
  // dummy data barchart pengeluaran bulanan
  final List<double> dataPengeluaran = [
    45.9, // Januari
    60.0, // Februari
    35.0, // Maret
    80.0, // April
    99.0, // Mei
    10.0, //juni
  ];

  // dummy data untuk kategori pengeluaran bulanan
  final List<Map<String, dynamic>> dataKategori = [
    {
      "nama": "Kuliner",
      "nominal": "Rp 500.000",
      "icon": Icons.restaurant,
      "progress": 0.5,
    },
    {
      "nama": "Transportasi",
      "nominal": "Rp 350.000",
      "icon": Icons.directions_car,
      "progress": 0.35,
    },
    {
      "nama": "Belanja",
      "nominal": "Rp 1.200.000",
      "icon": Icons.shopping_bag,
      "progress": 0.85,
    },
    {
      "nama": "Tagihan & Listrik",
      "nominal": "Rp 850.000",
      "icon": Icons.electric_bolt,
      "progress": 0.6,
    },
    {
      "nama": "Hiburan",
      "nominal": "Rp 200.000",
      "icon": Icons.movie,
      "progress": 0.2,
    },
  ];

  // set controller untuk mengendalikan posisi scroll nama bulan
  final ScrollController _scrollController = ScrollController();

  // set nama bulan
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
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 30,
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
                          vertical: 4,
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

            Padding(
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
                    const Text(
                      "Rp 99.000.000",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 12,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.trending_up,
                                color: Color(0XFFE4D329),
                                size: 14,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "12% ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFE4D329),
                            ),
                          ),
                          TextSpan(
                            text: "dari bulan lalu",
                            style: TextStyle(color: Color(0XFFE4D329)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 120,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.amberAccent,
                        tooltipBorderRadius: BorderRadius.circular(8),
                        tooltipPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            "Rp ${rod.toY.toStringAsFixed(1)} Jt",
                            const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 &&
                                value.toInt() < semuaBulan.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  //tampilkan nama bulan 3 huruf aja
                                  semuaBulan[value.toInt()].substring(0, 3),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(
                      dataPengeluaran.length,
                      (index) => BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: dataPengeluaran[index],
                            color: index == bulanTerpilih
                                ? const Color(0XFF0050CC)
                                : const Color(0X4D0050CC),
                            width: 18,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ),
                  ),
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
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataKategori.length,
              itemBuilder: (context, index) {
                final item = dataKategori[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailKategoriLaporan(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: const Color(0XFF0050CC),
                                child: Icon(
                                  item["icon"],
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
                                      item["nama"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF212121),
                                      ),
                                    ),
                                    Text(
                                      item["nominal"],
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
                              value: item["progress"],
                              minHeight: 8,
                              backgroundColor: const Color(0xFFEBEEF1),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0X4D0050CC),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
