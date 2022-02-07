import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.white,
    textColor: Colors.black,
    toastLength: Toast.LENGTH_LONG,
  );
}
