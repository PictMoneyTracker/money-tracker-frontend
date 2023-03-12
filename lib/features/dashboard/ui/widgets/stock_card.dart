import 'package:flutter/material.dart';

import '../../../../core/functions/general_functions.dart';
import '../../../stocks/stock_web_view.dart';

class StockCard extends StatelessWidget {
  const StockCard({
    super.key,
    required this.stockName,
    required this.stockSymbol,
  });

  final String stockName;
  final String stockSymbol;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stockName,
          style: const TextStyle(
              fontSize: 17.0,
              color: Colors.green,
              fontWeight: FontWeight.w500)),
      subtitle: Text(stockSymbol,
          style: const TextStyle(fontSize: 14.0, color: Colors.grey)),
      onTap: () {
        navigate(
          context,
          StockWebView(
            stockSymbol: stockSymbol,
          ),
        );
      },
    );
  }
}
