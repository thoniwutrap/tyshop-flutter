import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyshop_app/ui/customview/dots_indicator.dart';

import 'product_indicator.dart';


class ProductScreen extends StatelessWidget {
  String documentID;
  ProductScreen({this.documentID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductIndicator>(
        builder: (context) => ProductIndicator(),
        child: ProductDetail(documentID: documentID,)
    );
  }
}


class ProductDetail extends StatefulWidget {
  String documentID;
  ProductDetail({Key key,this.documentID}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>  with AutomaticKeepAliveClientMixin<ProductDetail> {
  int _current = 0;

  @override
  bool get wantKeepAlive => true;
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final product = Provider.of<ProductIndicator>(context);
    final _controller = new PageController();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("products").document(
            widget.documentID).collection("details").snapshots(),
        builder: (context, snapshot) {
          var userDocument = snapshot.data.documents[0];
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
              return NestedScrollView(
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace:
                      FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              //opacity: top == 80.0 ? 1.0 : 0.0,
                              opacity: 1.0,
                              child: Text(
                                top.toString(),
                                style: TextStyle(fontSize: 12.0),
                              )),
                          background: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              PageView.builder(
                                controller: _controller,
                                physics: new AlwaysScrollableScrollPhysics(),
                                itemCount: userDocument['image'].length,
                                itemBuilder: (BuildContext context, int index){
                                  return Container(
                                    child: FadeInImage.assetNetwork(
                                        image : userDocument['image'][index],
                                        fit: BoxFit.cover,
                                        width: 1000.0,
                                        placeholder: 'assets/images/bg_loading.png'),
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: DotsIndicator(
                                      controller: _controller,
                                      itemCount: userDocument['image'].length,
                                      onPageSelected: (int page) {
                                        _controller.animateToPage(
                                          page,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),

                  ];
                },
                body: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  child: new CircleAvatar(
                                    child: ClipOval(
                                        child: Container(
                                            child: Image.network(
                                                userDocument['image'][0]
                                            )),
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                  ),
                                  width: 30.0,
                                  height: 30.0,

                                  padding: const EdgeInsets.all(2.0), // borde width
                                  decoration: new BoxDecoration(
                                    color: Colors.black.withOpacity(0.5), // border color
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.white.withOpacity(1),
                                        blurRadius: 10.0,
                                      )
                                    ],
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text("Oarsandalps",style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),),
                                  ),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.monetization_on,color: Colors.orange[800],size: 30,),
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite_border,size: 30,),
                              ),
                              IconButton(
                                icon: Icon(Icons.bookmark_border,size: 30,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Essential Kits",style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                            Text("฿59",style: TextStyle(
                              fontSize: 18,
                              color : Colors.black,
                              
                            ),),
                        ],
                      ),

                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}