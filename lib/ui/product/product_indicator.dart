import 'package:flutter/material.dart';


class ProductIndicator with ChangeNotifier{

  int _indx = 0;

  int getIndx() => _indx;

  void setIndxIndication(int indx) {
    _indx = indx;
    notifyListeners();
  }

}