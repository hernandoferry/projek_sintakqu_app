import 'package:flutter/material.dart';

class DetailKategoriLaporan extends StatefulWidget {
  const DetailKategoriLaporan({super.key});

  @override
  _DetailKategoriLaporanState createState() => _DetailKategoriLaporanState();
}

class _DetailKategoriLaporanState extends State<DetailKategoriLaporan> {
  // dummy data untuk kategori pengeluaran bulanan
  final List<Map<String, dynamic>> dataKategori = [
    {
      "nama": "Kebab",
      "nominal": "Rp 500.000",
      "icon": Icons.restaurant,
      "progress": 0.5,
      "tanggal": "01 Juni 2026",
    },
    {
      "nama": "Makan Pagi Sore",
      "nominal": "Rp 350.000",
      "icon": Icons.restaurant,
      "progress": 0.35,
      "tanggal": "01 Juni 2026",
    },
    {
      "nama": "Steak Swiss Bucther",
      "nominal": "Rp 1.200.000",
      "icon": Icons.restaurant,
      "progress": 0.85,
      "tanggal": "02 Juni 2026",
    },
    {
      "nama": "Jajan Belut listrik",
      "nominal": "Rp 850.000",
      "icon": Icons.restaurant,
      "progress": 0.6,
      "tanggal": "02 Juni 2026",
    },
    {
      "nama": "Pop Corn CGV",
      "nominal": "Rp 200.000",
      "icon": Icons.movie,
      "progress": 0.2,
      "tanggal": "03 Juni 2026",
    },
    {
      "nama": "Starbuck 10 cup",
      "nominal": "Rp 750.000",
      "icon": Icons.coffee,
      "progress": 0.35,
      "tanggal": "03 Juni 2026",
    },
    {
      "nama": "Kartika sari Bandung",
      "nominal": "Rp 1.200.000",
      "icon": Icons.restaurant,
      "progress": 0.85,
      "tanggal": "04 Juni 2026",
    },
    {
      "nama": "Roti Bakar megalodon",
      "nominal": "Rp 850.000",
      "icon": Icons.restaurant,
      "progress": 0.6,
      "tanggal": "04 Juni 2026",
    },
    {
      "nama": "Pempek unyil",
      "nominal": "Rp 200.000",
      "icon": Icons.movie,
      "progress": 0.2,
      "tanggal": "04 Juni 2026",
    },
  ];

  List<String> listBulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktobe",
    "November",
    "Desember",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kategori"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFE0E3E6), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                width: double.infinity,
                height: 149,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF001A41), Color(0xFF0050CC)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.restaurant,
                            color: Color(0x60FFFFFF),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Kategori Pengeluaran ${listBulan[DateTime.now().month - 1]} 2026",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0x60FFFFFF),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "Kuliner",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        height: 33,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0x1AFFFFFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "TOTAL Rp 6.100.000",
                              style: TextStyle(
                                fontSize: 14,
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
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                children: [
                  Text(
                    "Riwayat Transaksi",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    "Urutkan",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color(0XFF0050CC),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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
                              radius: 20,
                              backgroundColor: const Color(0XFF0050CC),
                              child: Icon(
                                item["icon"],
                                color: const Color(0xFFFFFFFF),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Menggunakan Column baru agar teks Nama dan Tanggal tersusun bertingkat di sebelah kiri
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Rata kiri rapi
                                    children: [
                                      Text(
                                        item["nama"],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF212121),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ), // Jarak tipis ke teks tanggal
                                      Text(
                                        // Mengambil data tanggal dari map dataKategori (atau berikan nilai default jika null)
                                        item["tanggal"] ?? "04 Juni 2026",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Color(
                                            0xFF757575,
                                          ), // Warna abu-abu halus untuk informasi tanggal
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item["nominal"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFBA1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
