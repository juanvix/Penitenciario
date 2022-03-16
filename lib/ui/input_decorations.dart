import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 16, 148, 49)),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 9, 129, 55), width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Color.fromARGB(255, 25, 151, 36))
            : null);
  }
}
