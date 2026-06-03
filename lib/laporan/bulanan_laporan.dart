import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BulananLaporan extends StatefulWidget {
  const BulananLaporan({super.key});

  @override
  _BulananLaporanState createState() => _BulananLaporanState();
}

class _BulananLaporanState extends State<BulananLaporan> {
  //dummy data barchart pengeluaran bulanan
  final List<double> dataPengeluaran = [
    45.9, // Januari
    60.0, // Februari
    35.0, // Maret
    80.0, // April
    99.0, // Mei (Sesuai dengan Rp 99.000.000 Anda)
  ];
  //dummy data untuk kategori pengeluaran bulanan
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
          children: [
            const SizedBox(height: 24),
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
                        // color: Color(0XFFE4D329),
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tren Pengeluaran Bulanan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181C1E),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0XFF0050CC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E3E6)),
              ),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => const Color(0xFFFFFFFF),
                      tooltipBorder: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          'Rp ${rod.toY.toInt()} Juta',
                          const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const gayaTeks = TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Jan', style: gayaTeks);
                            case 1:
                              return const Text('Feb', style: gayaTeks);
                            case 2:
                              return const Text('Mar', style: gayaTeks);
                            case 3:
                              return const Text('Apr', style: gayaTeks);
                            case 4:
                              return const Text('Mei', style: gayaTeks);
                            default:
                              return const Text('');
                          }
                        },
                        reservedSize: 20,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(dataPengeluaran.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: dataPengeluaran[index],
                          color: const Color(0xFFE4D329),
                          width: 50,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pengeluaran Per Kategori Bulan Ini",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181C1E),
                  ),
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataKategori.length,
              itemBuilder: (context, index) {
                final item = dataKategori[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E3E6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                );
              },
            ),
            const SizedBox(height: 24),
            Text("boom"),
          ],
        ),
      ),
    );
  }
}
