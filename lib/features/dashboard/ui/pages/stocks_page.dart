import 'package:flutter/material.dart';

import '../../../../core/api_service/firebase_crud_service/stock_service/models/stock_model.dart';
import '../mt_dashboard.dart';
import '../widgets/balance_card.dart';

class StocksPage extends StatelessWidget {
  const StocksPage({
    super.key,
    required this.stocks,
  });

  final List<StockModel> stocks;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BalanceCard(),
        const SizedBox(
          height: 25,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const Text(
            'Stocks History',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Expanded(
          child: TransactionHistory(),
        ),
      ],
    );
  }
}
