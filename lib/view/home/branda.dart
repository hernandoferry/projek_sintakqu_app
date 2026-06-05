import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Branda extends StatefulWidget {
  const Branda({super.key});

  @override
  _BrandaState createState() => _BrandaState();
}

class _BrandaState extends State<Branda> {
  void tampilkanPengeluaranTerakhir(BuildContext context) {
    // Data statis berisi 10 daftar pengeluaran terakhir (diurutkan dari yang paling baru)
    final List<Map<String, String>> pengeluaranTerakhir = [
      {
        "judul": "Makan Siang",
        "kategori": "Konsumsi",
        "waktu": "Hari ini, 12:30",
        "nominal": "-Rp 45.000",
      },
      {
        "judul": "Isi Bensin Motor",
        "kategori": "Transportasi",
        "waktu": "Hari ini, 08:15",
        "nominal": "-Rp 30.000",
      },
      {
        "judul": "Kopi Susu Sore",
        "kategori": "Konsumsi",
        "waktu": "Kemarin, 16:00",
        "nominal": "-Rp 25.000",
      },
      {
        "judul": "Token Listrik Rumah",
        "kategori": "Tagihan",
        "waktu": "Kemarin, 10:00",
        "nominal": "-Rp 100.000",
      },
      {
        "judul": "Belanja Bulanan",
        "kategori": "Kebutuhan",
        "waktu": "24 Mei, 19:30",
        "nominal": "-Rp 350.000",
      },
      {
        "judul": "Langganan Netflix",
        "kategori": "Hiburan",
        "waktu": "23 Mei, 07:00",
        "nominal": "-Rp 54.000",
      },
      {
        "judul": "Obat Apotek",
        "kategori": "Kesehatan",
        "waktu": "22 Mei, 14:20",
        "nominal": "-Rp 65.000",
      },
      {
        "judul": "Sewa Lapangan Futsal",
        "kategori": "Olahraga",
        "waktu": "21 Mei, 20:00",
        "nominal": "-Rp 120.000",
      },
      {
        "judul": "Cuci Sepatu",
        "kategori": "Perawatan",
        "waktu": "21 Mei, 11:15",
        "nominal": "-Rp 40.000",
      },
      {
        "judul": "Parkir Mall",
        "kategori": "Transportasi",
        "waktu": "20 Mei, 18:45",
        "nominal": "-Rp 10.000",
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Membuat tinggi bottom sheet bisa ditarik dinamis
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65, // Membuka sheet langsung setinggi 65% layar
          minChildSize: 0.4,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF1F4F7),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16), // Sudut lengkung atas rounded rapi
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Handle Bar (Garis penarik di atas)
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

                  // 2. Area Judul & Informasi Jumlah Data
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Daftar Pengeluaran Terakhir",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              0xFF001A41,
                            ), // Warna gelap senada dengan gradient atas Anda
                          ),
                        ),
                        Text(
                          "Terbaru",
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF0050CC),
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

                  // 3. Daftar List Riwayat yang bisa di-scroll
                  Expanded(
                    child: ListView.builder(
                      controller:
                          scrollController, // Wajib disinkronkan dengan sheet controller
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: pengeluaranTerakhir.length,
                      itemBuilder: (context, index) {
                        final item = pengeluaranTerakhir[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 2,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFF7FAFD),
                            radius: 20,
                            child: const Icon(
                              Icons.arrow_outward_rounded,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            item["judul"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF1F1F1F),
                            ),
                          ),
                          subtitle: Text(
                            "${item["kategori"]} • ${item["waktu"]}",
                            style: const TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 11,
                            ),
                          ),
                          trailing: Text(
                            item["nominal"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF1F1F1F),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/user_dummy.png"),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 18,
                top: 18,
                bottom: 18,
              ),

              child: Column(
                children: [
                  Padding(
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
                    "Jhon Doe",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(Icons.notifications_none, color: Color(0xFF0050CC)),
          ],
        ),
        backgroundColor: const Color(0xFFF7FAFD),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[300], height: 1.0),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Container(
              width: MediaQuery.of(context).size.width * 10,
              height: 149,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft, // Titik awal gradasi mulai
                  end: Alignment.bottomRight, // Titik akhir gradasi selesai
                  colors: [
                    Color(0xFF001A41), // Warna pertama (Hex Code)
                    Color(0xFF0050CC), // Warna kedua (Hex Code)
                  ],
                  stops: const [
                    0.0,
                    1.0,
                  ], // Opsional: mengatur distribusi perpindahan warna (0.0 - 1.0)
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 70),
                        child: Text(
                          "Total Pengeluaran September",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0x60FFFFFF),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 20),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0x80FFFFFF),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4, left: 20, right: 184),
                    child: Text(
                      "Rp 1.450.000",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 105),
                    child: Container(
                      height: 33,
                      width: MediaQuery.of(context).size.width * 10,
                      decoration: BoxDecoration(
                        color: Color(0x1AFFFFFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            const CircleAvatar(
                              backgroundColor: Color(0xFFFFDCC3),
                              radius: 15,
                              child: Icon(Icons.star, size: 16.67),
                            ),

                            Text(
                              "Membership Level : Standard",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFDCC3),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                Container(
                  width: 180.5,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Column(
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
                        'Rp 1.000.000',
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

                Spacer(),
                Container(
                  width: 180.5,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC07024), // Warna border kiri Anda
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
                        children: [
                          Spacer(),
                          Row(
                            children: [
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
                          Spacer(),
                          Text(
                            "Rp 1.450.000",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFC07024),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
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
                  height: 200, // Tentukan tinggi grafik
                  padding: const EdgeInsets.only(left: 2, right: 16),
                  child: LineChart(
                    LineChartData(
                      // 1. Mengatur Garis Grid Latar Belakang
                      gridData: const FlGridData(show: true),
                      // 2. Mengatur Judul / Angka di Sumbu X dan Y
                      titlesData: const FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      // 3. Mengatur border kotak grafik
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: const Color(0xff37434d),
                          width: 1,
                        ),
                      ),
                      // 4. Memasukkan Data Poin Grafik
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 0),
                            FlSpot(1, 300), // Koordinat (X, Y) -> Titik 1
                            FlSpot(2, 1500), // Titik 2
                            FlSpot(3, 50), // Titik 3
                            FlSpot(4, 50),
                            FlSpot(5, 40),
                            FlSpot(7, 40),
                            FlSpot(7, 40),
                          ],
                          isCurved: true, // Membuat garis melengkung (smooth)
                          color: const Color(0xFF0050CC), // Warna garis grafik
                          barWidth: 4, // Ketebalan garis
                          isStrokeCapRound: true,
                          dotData: const FlDotData(
                            show: true,
                          ), // Menampilkan titik koordinat
                          belowBarData: BarAreaData(
                            show:
                                true, // Menampilkan warna gradasi di bawah garis
                            color: const Color.fromARGB(
                              255,
                              12,
                              12,
                              12,
                            ).withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  height: 165,
                  decoration: BoxDecoration(
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
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 10,
                            right: 20,
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 15,
                            right: 21,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.takeout_dining,
                                color: Color(0XFF0050CC),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Coffe Bean",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "11 Okt 2026",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                "- Rp.65.000",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0XFFBA1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[400], // Mengubah warna garis
                          thickness: 1, // Ketebalan garis pembatas
                          indent: 20, // Jarak kosong di awal garis (kiri)
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 15,
                            right: 21,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.takeout_dining,
                                color: Color(0XFF0050CC),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Membuat teks di dalam Column rata kiri
                                children: const [
                                  Text(
                                    "Makan Pagi Sore",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "12 Okt 2026",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Text(
                                "- Rp.165.000",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0XFFBA1A1A),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
