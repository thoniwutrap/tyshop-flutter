import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordState with ChangeNotifier {
  String _password = "";
  String _confirmPassword = "";
  Color _buttonColor = Color(0xff58595B);


  PasswordState();

  getPassword() => _password;
  getConfirmPassword() => _confirmPassword;
  getButtonColor() => _buttonColor;

   void setPassword(String text) {
    _password = text;
    validatePassword();
    notifyListeners();
  }
  
  void setConfirmPassword(String text){
    _confirmPassword = text;
    validatePassword();
    notifyListeners();
  }

   bool validatePassword()  {
      if(getPassword().toString().isNotEmpty &&
      getConfirmPassword().toString().isNotEmpty &&
      (getPassword() == getConfirmPassword())){
          _buttonColor =  Colors.green;
        return true;
      }else{
           _buttonColor  = Color(0xff58595B);
        return false;
      }
  }
}