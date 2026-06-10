import 'package:flutter/material.dart';

class StatePencarianHelper extends StatefulWidget {
  final bool belumCari;

  const StatePencarianHelper({super.key, required this.belumCari});

  @override
  State<StatePencarianHelper> createState() => _StatePencarianHelperState();
}

// 💡 1. Tambahkan TickerProviderStateMixin untuk mengaktifkan pengatur animasi
class _StatePencarianHelperState extends State<StatePencarianHelper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 💡 2. Atur durasi satu siklus melayang naik-turun (2 detik)
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(
            reverse: true,
          ); // Membuat gerakan otomatis bolak-balik tanpa henti

    // 💡 3. Tentukan jarak melayang vertikal sejauh 12 piksel dengan transisi halus
    _animation = Tween<double>(
      begin: 0.0,
      end: 12.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose(); // 💡 Wajib di-dispose agar hemat baterai dan RAM HP
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: SizedBox(
                width: 96,
                height: 96,
                child: CircleAvatar(
                  backgroundColor: const Color(
                    0xFF0055CC,
                  ).withValues(alpha: 0.3),
                  radius: 48,
                  child: const Icon(
                    Icons.event_busy_outlined,
                    size: 40,
                    color: Color(0xFF0055cc),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Upsss... Belum Ada Data !!! ",
              style: TextStyle(
                color: Color(0XFF0055CC),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.only(left: 18, right: 18, bottom: 48),
              child: Text(
                "Pilih tanggal untuk melihat laporan harian transaksi anda secara rinci.",
                style: TextStyle(fontSize: 16, color: Color(0x800055CC)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
