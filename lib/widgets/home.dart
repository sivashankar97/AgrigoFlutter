import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:signinexample/services/store.dart';
import 'package:signinexample/widgets/constants.dart';
import '../models/store.dart';
import '../UserScreen/ProductsDetail.dart';
import 'home_top_info.dart';

class Home extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          // _showPage,

          HomeTopInfo(),

          Expanded(
            child: new AspectRatio(
              aspectRatio: 120/ 100,
              child: new Container(
                  height: 190,
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _store.loadProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Product> products = [];
                          for (var doc in snapshot.data.documents) {
                            var data = doc.data;
                            products.add(Product(
                                pId: doc.documentID,
                                pPrice: data[kProductPrice],
                                pName: data[kProductName],
                                pDescription: data[kProductDescription],
                                pLocation: data[kProductLocation],
                                pCategory: data[kProductCategory]));
                          }
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0, left: 10.0, right: 7.0),
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, Productdetails.id,
                                        arguments: products[index]),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 18,
                                          child: AspectRatio(
                                            aspectRatio: 75/ 100,
                                            child: Container(
                                              // width: 140,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(0.0, 4),
                                                      blurRadius: 4)
                                                ],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12.0),
                                                    bottomRight:
                                                        Radius.circular(12.0),
                                                    topRight:
                                                        Radius.circular(12.0),
                                                    topLeft:
                                                        Radius.circular(12.0)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20,
                                                    left: 10.0,
                                                    right: 7.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.network(
                                                      products[index].pLocation,
                                                    ),
                                                    new Text(
                                                        products[index].pName)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(child: new SizedBox(height: 5))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(child: Text('Loading...'));
                        }
                      })),
            ),
          ),
        ],
      ),
    );
  }
}
