import 'package:flutter/material.dart';

import '../../../stocks/stock_search_delegate.dart';

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
        // TODO: add to user's stock list
        showSearch(
          context: context,
          delegate: StockSearchDelegate(),
        );
      },
    );
  }
}
