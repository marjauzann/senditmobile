import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFF4338CA),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
}
