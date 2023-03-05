import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Lorem Ipsum'),
      subtitle: const Text('Lorem Ipsum'),
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(myData[index].imageUrl),
      // ),
      onTap: () {
        // Do something when the user taps on the container
      },
    );
  }
}
