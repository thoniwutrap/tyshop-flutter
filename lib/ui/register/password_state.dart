import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordState with ChangeNotifier {
  String _password = "";
  String _confirmPassword = "";
  bool _isButtonDisabled = false;

  PasswordState();
  getPassword() => _password;
  getConfirmPassword() => _confirmPassword;
  getButtonState() => _isButtonDisabled;

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
          _isButtonDisabled = true;
        return true;
      }else{
           _isButtonDisabled = false;
        return false;
      }
  }
}