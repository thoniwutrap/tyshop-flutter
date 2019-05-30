import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 final FirebaseAuth _auth = FirebaseAuth.instance;
 
 var _emailController = TextEditingController();
 var _passwordController = TextEditingController();
 var _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           elevation: 0,
           backgroundColor: Colors.transparent,
           title: Text(""),
            actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.close),
             color: Colors.black,
            onPressed: () => Navigator.of(context).pop(null),
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
              Center(child: Text("Sign Up",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),)),
                  Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: _emailController,
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
                  controller: _passwordController,
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
                Container(
                margin: EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: _confirmPasswordController,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
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
                    onPressed: () {
                      createUser();
                    },
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
       ),
    );
  }


  Future createUser() async{

  final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if(user!=null){
      print("succrss");
    }else{
      print("error");
    }
  }
}