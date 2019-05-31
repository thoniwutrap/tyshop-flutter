import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyshop_app/provider/user_auth.dart';
import 'package:tyshop_app/ui/dialog/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tyshop_app/ui/register/password_state.dart';
import 'package:tyshop_app/widget/flushbar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiProvider(
      providers: [
        ChangeNotifierProvider<UserRepository>(
            builder: (context) => UserRepository.instance()),
        ChangeNotifierProvider<PasswordState>(
            builder: (context) => PasswordState())
      ],
      child: Consumer2<UserRepository, PasswordState>(
        builder: (context, user, passwordstate, widget) {
          return RegisterScreenState(
              userRepository: user, passwordState: passwordstate);
        },
      ),
    ));
  }
}

class RegisterScreenState extends StatefulWidget {
  final UserRepository userRepository;
  final PasswordState passwordState;
  const RegisterScreenState({Key key, this.userRepository, this.passwordState})
      : super(key: key);
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreenState> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  Color buttonColor = Color(0xff58595B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(""),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            color: Colors.black,
            onPressed: () =>  Navigator.of(context, rootNavigator: true).pop()
          ),
        ],
        leading: new Container(),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/images/bg_register.png',
              scale: 1.1,
            ),
          ),
          Center(
              child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
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
              obscureText: true,
              onChanged: (change) => widget.passwordState.setPassword(change),
              keyboardType: TextInputType.number,
              controller: _passwordController,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
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
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              onChanged: (change) =>
                  widget.passwordState.setConfirmPassword(change),
              obscureText: true,
              keyboardType: TextInputType.number,
              controller: _confirmPasswordController,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                hintText: 'Confrim Password',
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
              margin: EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: CupertinoButton(   
                disabledColor: Color(0xff58595B),
                onPressed: widget.passwordState.getButtonState() ?    
                () async {
                  bool isSuccess = await widget.userRepository.register(
                      context, _emailController.text, _passwordController.text);
                  if (isSuccess) {
                    Navigator.of(context, rootNavigator: true).pop({
                      'email':_emailController.text,
                      'password':_passwordController.text
                      });
                  }
                } : null,
                color: Colors.green,
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
