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
          image: NetworkImage(
              'https://media.tenor.com/yQPfHp6AmGgAAAAi/money-with-wings-joypixels.gif'),
          height: 60,
        ),
      ],
    );
  }
}
