import 'package:flutter/material.dart';


class MenuPage extends StatelessWidget {
  const MenuPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fdsf",
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySecondPage(title: "fsdsfdsfff",),
    );
  }
}

class MySecondPage extends StatefulWidget {
  MySecondPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MySecondPage createState() => _MySecondPage();
}

class _MySecondPage extends State<MySecondPage> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'fsdfsdf',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    
    );
  }
}
