import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProductScreen extends StatelessWidget {
  String documentID;
  ProductScreen({this.documentID});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductDetail(documentID: documentID,),
    );
  }
}


class ProductDetail extends StatefulWidget {
  String documentID;
  ProductDetail({Key key,this.documentID}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Collapsing Toolbar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
                bottom: TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    new Tab(icon: new Icon(Icons.info), text: "Tab 1"),
                    new Tab(
                        icon: new Icon(Icons.lightbulb_outline), text: "Tab 2"),
                  ],
                ),
              ),

            ];
          },
          body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("products").document(widget.documentID).collection("details").snapshots(),
            builder: (context,snapshot){
              var userDocument = snapshot.data.documents[0];;
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
                  return Center(
                    child: Text(userDocument["detail"]),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
