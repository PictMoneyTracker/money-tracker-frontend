import 'package:flutter/material.dart';

navigate(BuildContext context, Widget newClass, {bool? isReplace}) async {
  if (isReplace != null && isReplace) {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => newClass));
  } else {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => newClass));
  }
}

scaffoldMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
