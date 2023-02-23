import 'package:flutter/material.dart';

class MtBottomNavbar extends StatelessWidget {
  const MtBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 25,
      selectedFontSize: 16,
      unselectedFontSize: 13,
      // currentIndex: currentIndex,
      // onTap: (index) => setState(() => currentIndex = index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Stocks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.paid),
          label: 'Stipend',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Allowance',
        ),
      ],
    );
  }
}
