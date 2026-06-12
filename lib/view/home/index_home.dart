import 'package:flutter/material.dart';
import 'package:sintakqu/view/home/branda.dart';
import 'package:sintakqu/view/laporan/index_laporan.dart';
import 'package:sintakqu/view/profile/index_profile.dart';
import 'package:sintakqu/view/transaksi/transaksi.dart';

class IndexHome extends StatefulWidget {
  const IndexHome({super.key});

  @override
  State<IndexHome> createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  int _currentIndexPage = 0;

  final List<Widget> _pages = [
    const Branda(),
    const Transaksi(),
    const IndexLaporan(),
    const IndexProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndexPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          border: Border(top: BorderSide(color: Color(0xFFC5C6CF), width: 1.0)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndexPage,
            onTap: (int index) {
              setState(() {
                _currentIndexPage = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF0050CC),
            unselectedItemColor: Color(0xFF75777F),
            items: [
              BottomNavigationBarItem(
                icon: _currentIndexPage == 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE1FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Icon(Icons.home),
                      )
                    : const Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: _currentIndexPage == 1
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE1FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Icon(Icons.swap_horiz),
                      )
                    : const Icon(Icons.swap_horiz),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: _currentIndexPage == 2
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE1FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Icon(Icons.bar_chart),
                      )
                    : const Icon(Icons.bar_chart),
                label: 'Laporan',
              ),
              BottomNavigationBarItem(
                icon: _currentIndexPage == 3
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE1FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Icon(Icons.person),
                      )
                    : const Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
