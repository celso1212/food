import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  String hintText;
  bool obscureText;
  TextEditingController textEditingController;

  MyInput({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        obscureText: obscureText,
        decoration:
            InputDecoration(hintText: hintText, border: OutlineInputBorder()),
        controller: textEditingController,
      ),
    );
  }
}
