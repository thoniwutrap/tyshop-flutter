import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tyshop_app/ui/customview/button_builder.dart';
import 'package:tyshop_app/ui/dialog/loading.dart';
import 'package:tyshop_app/ui/menu/menu.dart';
import 'package:tyshop_app/ui/register/register.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: ExactAssetImage('assets/images/demo_bg_login.jpg'),
          //         fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Colors.black.withOpacity(0.0)),
            ),
          ),
        ),
        Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/ic_logo.png',
                  scale: 1.1,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.grey.withAlpha(40),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey.withAlpha(40),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: RaisedButton(
                    onPressed: () {
                      DialogController.loadingDialog(context);
                    },
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              devideLine,
              Container(
                constraints: BoxConstraints(
                  maxWidth: 0 ?? MediaQuery.of(context).size.width / 1.5,
                ),
                margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                decoration: new BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: new LinearGradient(
                    colors: [Colors.indigo, Colors.indigo],
                  ),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 20),
                          child: Image.asset(
                            'assets/images/ic_facebook.png',
                            scale: 2,
                          )),
                      Text(
                        "Login with facebook",
                        style: TextStyle(
                            fontFamily: 'Roboto', color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30, left: 30),
                margin: EdgeInsets.only(top: 10),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.downToUp,
                            child: RegisterScreen()));
                  },
                  child: Text(
                    "DON'T HAVE AN ACCOUNT?",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget devideLine = Padding(
    padding: EdgeInsets.only(top: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.white10,
                  Colors.grey,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          width: 100.0,
          height: 1.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Text(
            "OR",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontFamily: "WorkSansMedium"),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white10,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          width: 100.0,
          height: 1.0,
        ),
      ],
    ),
  );
}
