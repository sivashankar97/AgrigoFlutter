import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signinexample/UserScreen/plants/plant.dart';
import 'package:signinexample/UserScreen/plants/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAppBar extends StatefulWidget {
      static String id = 'MyAppBar';

  final FirebaseUser user;

  MyAppBar({this.user});

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Your Code Number"),
              content: TextField(
                controller: customController,
              ),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5.0, child: Text("Submit"), onPressed: () {})
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('images/veg.png'), fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.2),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
               
              
                    SizedBox(
                      height: 30,
                    ),
                   
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Lets Plant",
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0),
                      )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            StreamBuilder(
              stream: Firestore.instance.collection('Plants').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading...");
                return Expanded(
                  flex: 2,
                  child: new GridView.builder(
                      itemCount: snapshot.data.documents.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return new GestureDetector(
                          child: new Container(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                elevation: 10.0,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: new Image.asset(
                                          storeItems[index].itemImage),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            // createAlertDialog(context);
                            Navigator.of(context).push(new CupertinoPageRoute(
                                builder: (BuildContext context) => HyApp(
                                      collname: snapshot.data.documents[index]
                                          ['name'],
                                    )));
                          },
                        );
                      }),
                );
              },
            )
            // ),
          ],
        ),
        //  )
      ),
    ));
  }
}
