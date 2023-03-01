import 'package:flutter/material.dart';

import '../mt_dashboard.dart';
import '../widgets/balance_card.dart';

class StipendPage extends StatelessWidget {
  const StipendPage({super.key});

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