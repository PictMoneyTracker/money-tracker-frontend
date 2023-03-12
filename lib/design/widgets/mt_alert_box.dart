import 'package:flutter/material.dart';

class MtAlertBox extends StatelessWidget {
  final String content;
  final String title;
  final Function onPressed;

  const MtAlertBox({
    Key? key,
    required this.content,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(color: Color.fromRGBO(10, 173, 18, 0.698))),
        ),
        TextButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: const Text('OK',
              style: TextStyle(color: Color.fromRGBO(10, 173, 18, 0.698))),
        ),
      ],
    );
  }
}
