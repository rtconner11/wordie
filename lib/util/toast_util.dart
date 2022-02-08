import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void showWordieToast(String text) {
  showToast(
    text,
    textPadding: const EdgeInsets.all(16.0),
    backgroundColor: Colors.red.shade300,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}
