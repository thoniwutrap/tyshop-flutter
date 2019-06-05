import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tyshop_app/model/products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with  AutomaticKeepAliveClientMixin<HomeScreen>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              if (!snapshot.hasData) return Text('No data finded!');
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                      children:
                      snapshot.data.documents.map((DocumentSnapshot document){
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Text(document['name']),
                              Text(document['desc']),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      }).toList()
                  ),
                ),
              );
          }
        });
  }

  void addFirestore() {
    Products _replyObj = new Products(
      name: "fdsf",
      desc: "fdsfdsfdsfdsfsdf",
    );
    CollectionReference dbReplies = Firestore.instance.collection('products');
    Firestore.instance.runTransaction((Transaction tx) async {
      var _result = await dbReplies.add(_replyObj.toJson());
      print(_result.toString());
    });
}


}
