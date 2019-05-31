import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {

 static void showInfoFlushbar(BuildContext context) {
    Flushbar(
      title: 'This action is prohibited',
      message: 'Lorem ipsum dolor sit amet',
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 3),
    ).show(context);
  }

  static void showFlushbar(String msg,BuildContext context) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    ).show(context);
  }


}