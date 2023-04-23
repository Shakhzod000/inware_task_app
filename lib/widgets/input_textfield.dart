import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  TextEditingController? textEditingController;
  final String hinText;
  InputTextField({
    super.key,
    required this.hinText,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hinText,
          hintStyle: const TextStyle(fontSize: 14),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 1.5))),
    );
  }
}
