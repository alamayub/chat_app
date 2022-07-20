import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
showMessage(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey.withOpacity(.5),
    textColor: Colors.black,
    fontSize: 13.0
  );
}