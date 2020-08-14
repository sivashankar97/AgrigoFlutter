import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:signinexample/UserScreen/HomeMain/homepage.dart';
import 'package:signinexample/UserScreen/LoginScreen/mainlogo.dart';
import 'package:signinexample/UserScreen/LoginScreen/signin.dart';
import 'package:signinexample/UserScreen/LoginScreen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signinexample/UserScreen/ProductsDetail.dart';
import 'package:signinexample/UserScreen/delivery.dart';
import 'package:signinexample/UserScreen/editprofile.dart';
import 'package:signinexample/UserScreen/intropage.dart';
import 'package:signinexample/UserScreen/messages.dart';
// import 'package:signinexample/UserScreen/HomeMain/userscreen.dart';
import 'package:signinexample/UserScreen/myHomePage.dart';
import 'package:signinexample/UserScreen/plant.dart';
import 'package:signinexample/UserScreen/plants/test.dart';
import 'package:signinexample/UserScreen/profile.dart';
import 'package:signinexample/UserScreen/splashscreen.dart';
import 'package:signinexample/provider/cartItem.dart';

// void main()async => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();
  final MyApp myApp = MyApp(
    initialRoute: isLogged ? MyHomePage.id : IntroPage.id,
  );
  runApp(myApp);
}
class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:initialRoute,
          routes: {
            Agroprofile.id:(context) => Agroprofile(),
            IntroPage.id:(context) => IntroPage(),
            Productdetails.id: (context) => Productdetails(),
            MyHomePage.id: (context) => MyHomePage(),
            OnboardingScreen.id:(context) =>OnboardingScreen(),
            PlantPage.id:(context) => PlantPage(),
            AgriGoMessages.id:(context) => AgriGoMessages(),
            Agrodelivery.id:(context)=> Agrodelivery(),
            EditUser.id: (context) => EditUser(),
            MyAppBar.id:(context) => MyAppBar(),
          }),
    );
  }
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isLogged() async {
    try {
      final FirebaseUser user = await _firebaseAuth.currentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }
}
