import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tyshop_app/ui/page/home/HomeScreen.dart';
import 'package:tyshop_app/ui/page/location/LocationScreen.dart';
import 'package:tyshop_app/ui/page/notify/NotifyScreen.dart';
import 'package:tyshop_app/ui/page/profile/ProfileScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySecondPage(),
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
  static final AppBar _defaultBar = AppBar(
    centerTitle: true,
    title: Text('Products', style: TextStyle(color: Colors.black)),
    leading: IconButton(
      icon: new Icon(Icons.menu, color: Colors.black),
      onPressed: () {},
    ),
    actions: <Widget>[
      Stack(
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              print("fdfsf");
            },
          ),
          new Positioned(
              top: 3.0,
              right: 4.0,
              child: new Center(
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(3.0),
                    color: Colors.red,
                    child: new Text(
                      "12",
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),
        ],
      ),
      IconButton(
        icon: new Icon(Icons.search, color: Colors.black),
        onPressed: () {
          print("fdfsf");
        },
      ),
    ],
    backgroundColor: Colors.white,
  );

  int bottomSelectedIndex = 0;

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  static PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _defaultBar,
      body: Container(
          child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: <Widget>[
          Container(
            key: new PageStorageKey('page1'),
            child: HomeScreen(),
          ),
          Container(
            key: new PageStorageKey('page2'),
            child: LocationScreen(),
          ),
          Container(
            key: new PageStorageKey('page3'),
            child: NotificationScreen(),
          ),
          Container(
            key: new PageStorageKey('page4'),
            child: ProfileScreen(),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child:
              IconButton(
                icon: bottomSelectedIndex == 0
                    ? Image.asset(
                  'assets/images/ic_home_active.png',
                  width: 25,
                  height: 25,
                )
                    : Image.asset(
                  'assets/images/ic_home.png',
                  width: 25,
                  height: 25,
                ),
                onPressed: (){
                  bottomTapped(0);
                },
              )),
              Expanded(child: IconButton(
                icon: bottomSelectedIndex == 1
                    ? Image.asset(
                  'assets/images/ic_location_active.png',
                  width: 25,
                  height: 25,
                )
                    : Image.asset(
                  'assets/images/ic_location.png',
                  width: 25,
                  height: 25,
                ),
                onPressed: (){
                  bottomTapped(1);
                },)),
              Expanded(child: FlatButton(
                onPressed: (){

                },)),
              Expanded(child: IconButton(
                icon: bottomSelectedIndex == 2
                    ? Image.asset(
                  'assets/images/ic_notification_active.png',
                  width: 25,
                  height: 25,
                )
                    : Image.asset(
                  'assets/images/ic_notification.png',
                  width: 25,
                  height: 25,
                ),
                onPressed: (){
                  bottomTapped(2);
                },)),
              Expanded(child: IconButton(
                icon: bottomSelectedIndex == 3
                    ? Image.asset(
                  'assets/images/ic_profile_active.png',
                  width: 25,
                  height: 25,
                )
                    : Image.asset(
                  'assets/images/ic_profile.png',
                  width: 25,
                  height: 25,
                ),
                onPressed: (){
                  bottomTapped(3);
                },)),
            ],
          )
      ),


      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: new FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          tooltip: 'Increment',
          child: Image.asset('assets/images/ic_scanner.png',
              width: 33, height: 33),
          elevation: 4.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
