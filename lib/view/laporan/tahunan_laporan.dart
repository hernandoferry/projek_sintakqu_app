import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintakqu/services/transaksi_service.dart';

class TahunanLaporan extends StatefulWidget {
  const TahunanLaporan({super.key});

  @override
  State<TahunanLaporan> createState() => _TahunanLaporanState();
}

class _TahunanLaporanState extends State<TahunanLaporan> {
  late Future<double> _totalTahunan;
  late Future<List<Map<String, dynamic>>> _trendTahunan;
  late Future<List<Map<String, dynamic>>> _kategoriTahunan;

  @override
  void initState() {
    super.initState();

    _totalTahunan = TransaksiService().getTotalPengeluaranTahunan();
    _trendTahunan = TransaksiService().getTrendPengeluaranTahunan();
    _kategoriTahunan = TransaksiService().getKategoriTahunan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Tahunan"),
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
                  color: const Color(0xFF001A41),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "TOTAL PENGELUARAN TAHUN INI",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFFFFFFFF),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<double>(
                      future: _totalTahunan,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(
                            color: Color(0XFFE4D329),
                          );
                        }

                        final total = snapshot.data!;

                        final format = NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        );

                        return Text(
                          format.format(total),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFE4D329),
                          ),
                        );
                      },
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
                                color: Color(0XFFFFFFFF),
                                size: 14,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "12% ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "dari tahun lalu"),
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
                  "Tren Pengeluaran Tahunan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181C1E),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _trendTahunan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final data = snapshot.data ?? [];

                if (data.isEmpty) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text("Belum ada data transaksi."),
                  );
                }

                double maxY = 0;

                for (final item in data) {
                  final total = (item['total'] as num).toDouble();

                  if (total > maxY) {
                    maxY = total;
                  }
                }

                maxY *= 1.2;

                return Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E3E6)),
                  ),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,

                      maxY: maxY,

                      gridData: const FlGridData(show: false),

                      borderData: FlBorderData(show: false),
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
                              final index = value.toInt();

                              if (index >= data.length) {
                                return const SizedBox();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  data[index]['tahun'].toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => const Color(0XFFE4D329),

                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final format = NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            );

                            return BarTooltipItem(
                              format.format(rod.toY),
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),

                      barGroups: List.generate(data.length, (index) {
                        final total = (data[index]['total'] as num).toDouble();

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: total,
                              width: 36,
                              color: const Color(0xFF001A41),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rekap Per Kategori Tahun Ini",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181C1E),
                  ),
                ),
              ),
            ),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: _kategoriTahunan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final data = snapshot.data ?? [];

                if (data.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        "Belum ada data kategori.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                double totalSemua = 0;

                for (final item in data) {
                  totalSemua += (item['total'] as num).toDouble();
                }

                IconData getIcon(String kategori) {
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

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];

                    final kategori = item["kategori"];

                    final nominal = (item["total"] as num).toDouble();
                    final double progress = totalSemua == 0
                        ? 0.0
                        : (nominal / totalSemua).toDouble();
                    // final progress = totalSemua == 0 ? 0 : nominal / totalSemua;

                    final format = NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    );

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
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: const Color(0XFF001A41),
                                  child: Icon(
                                    getIcon(kategori),
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          kategori,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                      Text(
                                        format.format(nominal),
                                        style: const TextStyle(
                                          color: Color(0XFF001A41),
                                          fontWeight: FontWeight.bold,
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
                                value: progress,
                                minHeight: 8,
                                backgroundColor: const Color(0xFFEBEEF1),
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0XFF001A41),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Container(
            //   width: 380,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: const Color(0XFFE5E8EB),
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Icon(
            //         Icons.lightbulb_circle,
            //         size: 40,
            //         color: Color(0XFFE4D329),
            //       ),
            //       const SizedBox(width: 12),

            //       // Expanded(
            //       //   child: RichText(
            //       //     text: TextSpan(
            //       //       style: const TextStyle(
            //       //         fontSize: 14.0,
            //       //         color: Colors.black87,
            //       //         height: 1.5,
            //       //       ),
            //       //       children: [
            //       //         const TextSpan(
            //       //           text: "Analisis AI\n",
            //       //           style: TextStyle(
            //       //             fontWeight: FontWeight.bold,
            //       //             fontSize: 16.0,
            //       //             color: Colors.black,
            //       //             height: 2.0,
            //       //           ),
            //       //         ),

            //       //         const TextSpan(text: "Pengeluaran kategori "),
            //       //         const TextSpan(
            //       //           text: "Belanja",
            //       //           style: TextStyle(
            //       //             fontWeight: FontWeight.bold,
            //       //             color: Color(0xFF0050CC),
            //       //           ),
            //       //         ),
            //       //         const TextSpan(text: " meningkat "),
            //       //         const TextSpan(
            //       //           text: "15%",
            //       //           style: TextStyle(
            //       //             fontWeight: FontWeight.bold,
            //       //             fontSize: 15.0,
            //       //             color: Color(0xFF0050CC),
            //       //           ),
            //       //         ),
            //       //         const TextSpan(text: " dari tahun sebelumnya. "),
            //       //         const TextSpan(
            //       //           text: "Disarankan untuk meninjau kembali ",
            //       //         ),
            //       //         const TextSpan(
            //       //           text: "belanja bulanan",
            //       //           style: TextStyle(fontWeight: FontWeight.w600),
            //       //         ),
            //       //         const TextSpan(text: " Anda."),
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
