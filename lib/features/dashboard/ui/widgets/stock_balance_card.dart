import 'package:flutter/material.dart';

class StockBalanceCard extends StatelessWidget {
  const StockBalanceCard({super.key, required this.stocksBalance});
  final int stocksBalance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      height: 190,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Stocks Balance",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          Text(
            stocksBalance.toString(),
            style: const TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
