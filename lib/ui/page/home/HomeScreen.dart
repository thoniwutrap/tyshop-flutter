import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tyshop_app/model/products.dart';
import 'package:tyshop_app/ui/customview/star_display_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tyshop_app/ui/product/product_detail.dart';


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
    return  Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2,4),
                  itemBuilder: (context,index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    return Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ProductDetail(
                              documentID: ds.documentID,
                            )));
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image(
                                  height: 200,
                                  image: NetworkImage(ds['image']),
                                ),
                                Container(
                                  child: Text(ds['name'],style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey
                                  ),),
                                ),
                                Text("฿ ${ds['price']}",style: TextStyle(
                                  color: Colors.orange[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),),
                                Row(
                                  children: <Widget>[
                                    Text("฿20",style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[400],
                                      fontSize: 12
                                    ),),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text("-40%",style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12
                                      ),),
                                    )
                                  ],
                                ),
                                IconTheme(
                                  data: IconThemeData(
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  child: StarDisplay(value: 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                );
            }
          }),
    );
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
