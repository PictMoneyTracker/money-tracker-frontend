import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design/widgets/mt_loader.dart';
import '../../bloc/dashboard_bloc.dart';
import '../mt_dashboard.dart';
import '../widgets/balance_card.dart';

class StipendPage extends StatelessWidget {
  const StipendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is StipendPageLoadedState) {
              return BalanceCard(
                totalBalance: state.stipendBalance - state.stipendSpent,
                income: state.stipendBalance,
                expenses: state.stipendSpent,
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
            'Stipend History',
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
