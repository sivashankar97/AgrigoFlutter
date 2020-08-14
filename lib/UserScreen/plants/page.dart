// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';

// class PageIN extends StatefulWidget {
//   @override
//   _PageINState createState() => _PageINState();
// }

// class _PageINState extends State<PageIN> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       // child: ListView.builder(
//       //     itemCount: 2,
//       //     itemBuilder: (context, index) {
//       //       return ListTile(
//       //         title: Text("hello worlds"),
//       //       );
//       //     }
//       child: Column(
//         children: <Widget>[
//           StreamBuilder(
//             stream: Firestore.instance
//                 .collection("FukStudents")
//                 .document("raina")
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 var userDocument = snapshot.data;
//                  return Card(
//                         child: ListTile(
//                           title: Column(
//                             children: <Widget>[
//                               Expanded(
//                                 child: Text(userDocument["studentName"]),
//                               ),
//                               Expanded(
//                                 child: Text(userDocument["studentID"]),
//                               ),
//                               Expanded(
//                                 child:
//                                     Text(userDocument["StudentProgAAmID"]),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                     userDocument["StudentGPA"].toString()),
//                               ),
//                             ],
//                           ),
//                         )
//                         )
//                         ;
                
//                 // return ListView.builder(
//                 //     scrollDirection: Axis.vertical,
//                 //     shrinkWrap: true,

//                 //     // itemCount: snapshot.data.length,
//                 //     itemBuilder: (context, snapshot) {
//                 //       var documentSnapshot = snapshot.data;
//                 //       return Card(
//                 //         child: ListTile(
//                 //           title: Row(
//                 //             children: <Widget>[
//                 //               Expanded(
//                 //                 child: Text(documentSnapshot["studentName"]),
//                 //               ),
//                 //               Expanded(
//                 //                 child: Text(documentSnapshot["studentID"]),
//                 //               ),
//                 //               Expanded(
//                 //                 child:
//                 //                     Text(documentSnapshot["StudentProgAAmID"]),
//                 //               ),
//                 //               Expanded(
//                 //                 child: Text(
//                 //                     documentSnapshot["StudentGPA"].toString()),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       );
//                 //     });

//               }
//             },

// //             Widget build(BuildContext context) {
// //   return new StreamBuilder(
// //       stream: Firestore.instance.collection('COLLECTION_NAME').document('TESTID1').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) {
// //           return new Text("Loading");
// //         }
// //         var userDocument = snapshot.data;
// //         return new Text(userDocument["name"]);
// //       }
// //   );
// // }
//           ),
//         ],
//       ),
//     ));
//   }
// }
