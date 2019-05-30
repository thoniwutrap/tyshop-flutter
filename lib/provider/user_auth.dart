import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tyshop_app/ui/dialog/loading.dart';
import 'package:tyshop_app/widget/flushbar.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> register(BuildContext context,String email, String password) async{
    DialogController.loadingDialog(context);
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.of(context, rootNavigator: true).pop();
      FlushbarHelper.showFlushbar("Your account has been created", context);
      return true;
    } catch (signUpError) {
    if(signUpError is PlatformException) {
      switch(signUpError.code){
        case  'ERROR_EMAIL_ALREADY_IN_USE' : {
          Navigator.of(context, rootNavigator: true).pop();
          FlushbarHelper.showFlushbar("This account is already member", context);
        }
      }
     }
     return false;
    }
  }


  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}