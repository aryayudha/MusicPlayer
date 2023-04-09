import 'package:flutter/material.dart';

class UiStyle {

  static const titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);
  static const bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.1);
  static const labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w300, letterSpacing: 0.4);

  static InputDecoration formTextRounded = InputDecoration(
    fillColor: Colors.grey.withOpacity(0.1),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
    constraints: const BoxConstraints(maxHeight: 35),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none
    ),
  );
}