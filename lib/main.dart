import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tyshop_app/splash.dart';
import 'package:tyshop_app/ui/home/home.dart';
import 'package:tyshop_app/ui/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/Login':
            return PageTransition(
                child: LoginScreen(), type: PageTransitionType.fade);
            break;
          default:
          return null;
        }
      },
    );
  }
}
