// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:newagrigo/models/store.dart';
// import 'package:newagrigo/userScreens/cart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:signinexample/UserScreen/plants/test.dart';
// import 'package:signinexample/UserScreen/HomeMain/userscreen.dart';
// import 'package:newagrigo/admin/adminHome.dart';
import 'cart.dart';
import 'delivery.dart';
import 'profile.dart';
// import 'package:newagrigo/widgets/home_top_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'messages.dart';
// import 'ProductsDetail.dart';
import '../widgets/home.dart';
// import 'package:newagrigo/adminscreens/adminhome.dart ';
import 'plant.dart';

class MyHomePage extends StatefulWidget {
  static String id = 'MyHomePage';

  String usID;
  String usName;
  String usEmail;

  MyHomePage({this.usID,this.usEmail,this.usName});
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  BuildContext context;
  int currentTab = 0;

  // Pages
  Home homePage;
  MyAppBar plantPage;
  Agrodelivery cartpage;
  Agroprofile profilePage;

  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    homePage = Home();
    cartpage = Agrodelivery();
    plantPage = MyAppBar();
    profilePage = Agroprofile();
    pages = [
      homePage,
      plantPage,
      cartpage,
      profilePage,
    ];

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context,
		    height: 1920, // Optional
		    width: 1080, // Optional
			allowFontScaling: true, // Optional
	    );
    this.context = context;
    return ResponsiveWidgets.builder(
      height: 1920, // Optional
		    width: 1080, // Optional
			allowFontScaling: true,
      child: SafeArea(
        child: new Scaffold(
          // appBar: new AppBar(
          //   title: GestureDetector(
          //     child: new Text("Agri go"),
          //   ),
          //   backgroundColor: Colors.white,
          //   iconTheme: IconThemeData(color: Colors.grey[600]),
          //   centerTitle: true,
          //   actions: <Widget>[
          //     new IconButton(
          //         icon: new Icon(
          //           Icons.add_shopping_cart,
          //           color: Colors.green,
          //         ),
          //         onPressed: () {
          //           Navigator.pushNamed(context, Agrodelivery.id);
          //         }),
          //   ],
          // ),
          bottomNavigationBar: CurvedNavigationBar(
            index: currentTab,
            backgroundColor: Colors.grey[200],
            items: <Widget>[
              Icon(Icons.home, size: 25),
              Icon(Icons.bubble_chart, size: 25),
              Icon(Icons.video_library, size: 25),
              Icon(Icons.person, size: 25),
            ],
            onTap: (index) {
              setState(() {
                currentTab = index;
                currentPage = pages[index];
              });
            },
          ),
          body: new Container(
            child: currentPage,
          ),
        
        ),
      ),
    );
  }

  // openAdmin() {
  //   Navigator.of(context)
  //       .push(new CupertinoPageRoute(builder: (BuildContext context) {
  //     return new AdminHome();
  //   }));
  // }
}
