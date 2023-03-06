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
      title: Text(stockName),
      subtitle: Text(stockSymbol),
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
