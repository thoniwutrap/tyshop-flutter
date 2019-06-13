import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tyshop_app/splash.dart';
import 'package:tyshop_app/ui/login/login.dart';
import 'package:tyshop_app/ui/menu/menu.dart';

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
            return PageTransition(child: LoginScreen(), type: PageTransitionType.fade);
            break;
          case '/Menu':
            return PageTransition(child: MenuScreen(), type: PageTransitionType.fade);
            break;
          default:
          return null;
        }
      },
    );
  }
}
