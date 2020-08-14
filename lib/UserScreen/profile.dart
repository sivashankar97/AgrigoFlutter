import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signinexample/UserScreen/editprofile.dart';
import 'package:signinexample/UserScreen/intropage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signinexample/models/user.dart';

FirebaseUser loggedInUser;

class Agroprofile extends StatefulWidget {
  static String id = 'Agroprofile';

  @override
  _AgroprofileState createState() => _AgroprofileState();
}

class _AgroprofileState extends State<Agroprofile> {
  bool _fetchingData = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // _getUserData();

    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      setState(() {
        loggedInUser = user;
        print('this is:  ${loggedInUser.uid}');
        _fetchingData = false;
      });
    }
    // Similarly we can get email as well
    //final uemail = user.email;
    //  final QuerySnapshot result = await Firestore.instance
    //         .collection('users')
    //         .where('id', isEqualTo: uidd)
    //         .getDocuments();
    //     final List<DocumentSnapshot> documents = result.documents;
    // print(documents[0]['id']);
    // print(documents[0]['email']);
    //print(uemail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fetchingData
          ? CircularProgressIndicator()
          : new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .where('id', isEqualTo: loggedInUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();
                    List<Users> userdatas = [];
                    for (var poc in snapshot.data.documents) {
                      var deta = poc.data;
                      userdatas.add(Users(
                        uId: poc.documentID,
                        uName: deta['name'],
                        uAddress: deta['address'],
                        uMail: deta['email'],
                        uNumber: deta['number'],
                      ));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: userdatas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            new UserAccountsDrawerHeader(
                              accountName: new Text(userdatas[index].uName),
                              accountEmail: new Text(userdatas[index].uMail),
                              currentAccountPicture: new CircleAvatar(
                                backgroundColor: Colors.white,
                                child: new Icon(Icons.person),
                              ),
                            ),
                            new ListTile(
                              leading: new CircleAvatar(
                                child: new Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                              title: new Text("Order History"),
                            ),
                            new ListTile(
                                leading: new CircleAvatar(
                                  child: new Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                title: new Text("Update profile"),
                                onTap: () {
                                  Navigator.pushNamed(context, EditUser.id,
                                      arguments: userdatas[index]);
                                }),
                            new ListTile(
                                trailing: new CircleAvatar(
                                  child: new Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                title: new Text("logout"),
                                onTap: () {
                                  _delete();
                                })
                          ]);
                        });
                  },
                )
              ],
            ),
    );
  }

  void _delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);

    Navigator.pushNamed(context, IntroPage.id);
  }
}
