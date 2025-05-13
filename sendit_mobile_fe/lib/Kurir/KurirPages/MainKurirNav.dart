import 'package:flutter/material.dart';
import 'BottomNavigation.dart';
import 'HomeKurir.dart';
import 'HistoryKurir.dart';
import 'ProfileKurir.dart'; // You'll need to create this file

class MainKurirNavigation extends StatefulWidget {
  const MainKurirNavigation({super.key});

  @override
  _MainKurirNavigationState createState() => _MainKurirNavigationState();
}

class _MainKurirNavigationState extends State<MainKurirNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeKurir(),
    const HistoryKurir(),
    const ProfileKurir(), // Create this widget
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        items: _navItems,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
