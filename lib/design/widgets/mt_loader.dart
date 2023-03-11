import 'package:flutter/material.dart';

class MtLoader extends StatelessWidget {
  const MtLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Track your money, easily!',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        // CircularProgressIndicator(),
        Image(
          image: AssetImage('assets/images/money_with_wings.gif'),
          height: 60,
        ),
      ],
    );
  }
}
