// import 'package:newagrigo/userScreens/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signinexample/UserScreen/delivery.dart';
import '../models/store.dart';
import 'package:signinexample/provider/cartItem.dart';
import 'package:provider/provider.dart';

class Productdetails extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductdetailsState createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: new AppBar(
        title: new Text("Agri go"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        centerTitle: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      // floatingActionButton: new Stack(
      //   alignment: Alignment.topLeft,
      //   children: <Widget>[
      //     new FloatingActionButton(
      //       backgroundColor: Colors.green,
      //       onPressed: () {
      //         Navigator.pushNamed(context, Agrodelivery.id);
      //       },
      //       child: new Icon(Icons.shopping_cart),
      //     ),
      //     new CircleAvatar(
      //       radius: 10.0,
      //       backgroundColor: Colors.red,
      //       child: new Text(
      //         _quantity.toString(),
      //         style: new TextStyle(color: Colors.white, fontSize: 12.0),
      //       ),
      //     )
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        // color: Colors.white,
        elevation: 4.0,
        shape: new CircularNotchedRectangle(),
        // child: new Container(
        //   height: 50.0,
        //   child: new Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[

        child: Container(
            width: (screenSize.width - 20) / 2,
            child: new FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(16),
              splashColor: Colors.blueAccent,
              onPressed: () {
                addToCart(context, product);
              },
              child: Text(
                "Add to cart",
                style: TextStyle(fontSize: 20.0),
              ),
            )),
        //     ],
        //   ),
        // ),
      ),
      body: Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Container(
                  width: 375.0,
                  height: 250.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                        // offset: Offset(
                        //   5.0, // Move to right 10  horizontally
                        //   5.0, // Move to bottom 10 Vertically
                        // ),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)
                        // topRight: Radius.circular(15.0),
                        // topLeft: Radius.circular(15.0)
                        ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50.0, left: 50.0, right: 40.0),
                              child: Image.network(
                                product.pLocation,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              new Container(
                child: new Column(
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        width: screenSize.width,
                        margin: new EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new SizedBox(
                              height: 10.0,
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Text(
                                      product.pName,
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                                new Text(
                                  '\$${product.pPrice}',
                                  style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.red[500],
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Card(
                      child: new Container(
                        width: screenSize.width,
                        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                              "Description",
                              style: new TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                              product.pDescription,
                              style: new TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            new SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Card(
                      child: new Container(
                        width: screenSize.width,
                        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new SizedBox(
                              height: 5.0,
                            ),
                            new Text(
                              "Amount",
                              style: new TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.blue,
                                    child: GestureDetector(
                                      onTap: add,
                                      child: SizedBox(
                                        child: Icon(Icons.add),
                                        height: 32,
                                        width: 32,
                                      ),
                                    ),
                                  ),
                                ),
                                new Text(
                                  _quantity.toString(),
                                ),
                                ClipOval(
                                  child: Material(
                                    color: Colors.blue,
                                    child: GestureDetector(
                                      onTap: subtract,
                                      child: SizedBox(
                                        child: Icon(Icons.remove),
                                        height: 32,
                                        width: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      _showDialogFailed();
    } else {
      cartItem.addProduct(product);
      _showDialogSucces();
    }
  }

  void _showDialogSucces() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Added to the cart"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
   void _showDialogFailed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Already added"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
