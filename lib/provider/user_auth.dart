import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tyshop_app/ui/dialog/loading.dart';


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

  Future<bool> register(
     BuildContext context, String name,String email, String password) async {
    DialogController.loadingDialog(context);
  print(name);
    try {
        await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

          _user =  await _auth.currentUser();
              var userUpdateInfo = new UserUpdateInfo();
             userUpdateInfo.displayName = name;
           _user.updateProfile(userUpdateInfo);
          print('USERNAME IS: ${user.displayName}');
           return true;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        switch (signUpError.code) {
          case 'ERROR_EMAIL_ALREADY_IN_USE':
//            FlushbarHelper.showFlushbar(
//                "This account is already member", context);
          print("ERROR_EMAIL_ALREADY_IN_USE");
            break;
          case 'ERROR_INVALID_EMAIL':
//            FlushbarHelper.showFlushbar("email is invalid", context);
            break;
          default:
//            FlushbarHelper.showFlushbar(signUpError.code, context);
            break;
        }
      }
      return false;
    }finally{
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<bool> signIn(BuildContext context,String email, String password) async {
     DialogController.loadingDialog(context);
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (signUpError) {
        if (signUpError is PlatformException) {
          print(signUpError.code);
      }
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }finally{
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

   Future currentUser() async{
     var displayName = await _user.displayName;
     print(displayName);
     return displayName;
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
