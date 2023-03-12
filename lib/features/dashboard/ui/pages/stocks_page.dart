import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_service/firebase_crud_service/stock_service/models/stock_model.dart';
import '../../../../design/widgets/mt_loader.dart';
import '../../bloc/dashboard_bloc.dart';
import '../mt_dashboard.dart';
import '../widgets/stock_balance_card.dart';

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
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is StocksPageLoadedState) {
              return StockBalanceCard(
                stocksBalance: state.stockBalance,
              );
            }
            return const Center(
              child: MtLoader(),
            );
          },
        ),
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
              fontWeight: FontWeight.w500,
              color: Colors.green,
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
