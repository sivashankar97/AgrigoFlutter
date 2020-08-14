import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signinexample/models/store.dart';
import 'package:signinexample/provider/cartItem.dart';
import 'package:signinexample/services/store.dart';
import 'package:signinexample/widgets/constants.dart';

String ussname;
String ussemail;
String ussaddress;
String ussnumber;

class Agrodelivery extends StatefulWidget {
  static String id = 'Agrodelivery';

  @override
  _AgroState createState() => _AgroState();
}

class _AgroState extends State<Agrodelivery> {
  @override
  void initState() {
    super.initState();
    someMethod();
  }

  someMethod() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final ussid = user.uid;
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: ussid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    ussname = documents[0]['name'];
    ussemail = documents[0]['email'];
    ussaddress = documents[0]['address'];
    ussnumber = documents[0]['number'];
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 596,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 100,
                              child: Row(
                                children: <Widget>[
                                  // CircleAvatar(
                                  // radius: screenHeight * .15 / 2,

                                  Image.network(products[index].pLocation),
                                  // ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                products[index].pName,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '\$ ${products[index].pPrice}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            products[index]
                                                .pQuantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0))),
                                          height: 500,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.white,
                                            iconSize: 28,
                                            onPressed: () {
                                              Provider.of<CartItem>(context,
                                                      listen: false)
                                                  .deleteProduct(
                                                      products[index]);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // new Text(getTotallPrice(products).toString())
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        offset: Offset(1, 1),
                                        blurRadius: 4)
                                  ],
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0))),
                            ),
                          );
                        },
                        itemCount: products.length,
                      ),
                    ),
                    Text(getTotallPrice(products).toString()),
                  ],
                ),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 596,
                    child: Center(
                      child: Text('Cart is Empty'),
                    ),
                  ),
                ),
              );
            }
          }),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * .08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                onPressed: () {
                  showCustomDialog(products, context);
                },
                child: Text('Order'.toUpperCase()),
                color: kMainColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  // rest of the code|  do stuff

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotallPrice(products);
    // var orderPerson = ussname;
    // var orderAddress = ussaddress;
    // var orderEmail = ussemail;
    var mobileNo;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders(
                  {kTotallPrice: price, 
                   kmobileNo: mobileNo, 
                   kOrderPerson:ussname,
                   kOrderAddress:ussaddress,
                   kOrderEmail:ussemail,
                   kOrderNumber:ussnumber}, products);
              products.clear();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Orderd Successfully'),
              ));
              Navigator.pop(context);
            } catch (ex) {
              print(ex.message);
            }
          },
          child: Text('Confirm'),
        )
      ],
      content: TextField(
        onChanged: (value) {
          mobileNo = value;
        },
        decoration: InputDecoration(hintText: 'Enter your Address'),
      ),
      title: Text('Totall Price  = \$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotallPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
