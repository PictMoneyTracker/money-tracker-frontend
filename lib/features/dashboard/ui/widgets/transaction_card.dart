import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        color: Colors.blue,
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Center(child: Text('Elevated Card')),
        ),
      ),
    );
  }
}
