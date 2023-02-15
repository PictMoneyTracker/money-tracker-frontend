
import 'package:flutter/material.dart';

import 'widgets/transaction_card.dart';

class MtDashboard extends StatefulWidget {
  const MtDashboard({super.key});

  @override
  State<MtDashboard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MtDashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Stipend',
      style: optionStyle,
    ),
    Text(
      'Index 1: Allowance',
      style: optionStyle,
    ),
    Text(
      'Index 2: Stock',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          tooltip: 'Show Menu',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
            tooltip: 'Show Settings',
          ),
        ],
      ),
      body: Column(
        children: const [
          SizedBox(height: 30),
          TransactionCard(),
          SizedBox(height: 30),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Stipend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Allowance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Stock',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
