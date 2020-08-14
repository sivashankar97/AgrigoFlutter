// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:signinexample/UserScreen/myHomePage.dart';
// import 'package:signinexample/main.dart';

// class UserScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _UserScreen();
// }

// class _UserScreen extends State<UserScreen> with WidgetsBindingObserver {
//   Map<String, dynamic> _useData = Map<String, dynamic>();
//   bool _fetchingData = true;

//   Future<void> _getUserData() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       setState(() {
//         _useData['name'] = prefs.get('name');
//         _useData['gender'] = prefs.get('gender');
//         _useData['intro'] = prefs.get('intro');
//         _useData['email'] = prefs.get('email');
//         _useData['number'] = prefs.get('number');

//         _fetchingData = false;
//       });
//     } catch (e) {}
//   }

//   @override
//   void initState() {
//     _getUserData();
//     super.initState();
//   }

//   Widget titleSection() {
//     return Container(
//       padding: const EdgeInsets.all(32),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     _useData['name'],
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   _useData['email'],
//                   style: TextStyle(
//                     color: Colors.grey[500],
//                   ),
//                 ),
//                 Text(
//                   _useData['number'],
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _deleteUser() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: RaisedButton(
//         onPressed: () {
//           _delete();
//         },
//         child: Text('Log out'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         exit(0);
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('This is user screen'),
//           automaticallyImplyLeading: false,
//         ),
//         body: _fetchingData
//             ? CircularProgressIndicator()
//             : ListView(
//                 children: [titleSection(), _deleteUser()],
//               ),
//       ),
//     );
//   }

//   void _delete() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLogin', false);

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => IntroPage()),
//     );
//   }
// }
