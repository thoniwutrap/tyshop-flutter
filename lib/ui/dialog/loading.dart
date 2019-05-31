import 'package:flutter/material.dart';

class DialogController {
 
    static loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          );
        });
  }
}