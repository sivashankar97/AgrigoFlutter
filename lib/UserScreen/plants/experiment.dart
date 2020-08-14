import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Experiment extends StatefulWidget {
  @override
  _ExperimentState createState() => _ExperimentState();
}

class _ExperimentState extends State<Experiment> {
  final firestoreInstance = Firestore.instance;

  // void _onPressed() {
  //   firestoreInstance.collection("users").document("Task").setData({
  //     "name": "john",
  //     "age": 50,
  //     "email": "example@example.com",
  //     "address": {"street": "street 24", "city": "new york"}
  //   }).then((value) {
  //     print("Task");
  //     firestoreInstance
  //         .collection("users")
  //         .document("Task")
  //         .collection("pets")
  //         .add({"petName": "blacky", "petType": "dog", "petAge": 1});
  //   });

  //   // firestoreInstance.collection("users").add({
  //   //   "name": "john",
  //   //   "age": 50,
  //   //   "email": "example@example.com",
  //   //   "address": {"street": "street 24", "city": "new york"}
  //   // }).then((value) {
  //   //   print(value.documentID);
  //   // });

//   firestoreInstance.collection("users").add({
//   "name": "john",
//   "age": 50,
//   "email": "example@example.com",
//   "address": {"street": "street 24", "city": "new york"}
// }).then((value) {
//   print(value.documentID);
//   firestoreInstance
//       .collection("users")
//       .document(value.documentID)
//       .collection("pets")
//       .add({"petName": "blacky", "petType": "dog", "petAge": 1});
// });

//   void _onPressed() async{
//   var firebaseUser = await FirebaseAuth.instance.currentUser();
//   firestoreInstance.collection("users").document(firebaseUser.uid).setData(
//   {
//     "name" : "john",
//     "age" : 50,
//     "email" : "example@example.com",
//     "address" : {
//       "street" : "street 24",
//       "city" : "new york"
//     }
//   }).then((_){
//     print("success!");
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my flutter app"),
      ),
      body: new Container(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          // new FloatingActionButton(onPressed: () {
          //   _onDressed();
          // }),
          
      StreamBuilder(
        stream: Firestore.instance
            .collection('Plants')
            .document('Chillies')
            .collection('Tasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    //return buildListItem(context, snapshot.data.documents[index]);

                    return Card(
                      child: ExpansionTile(
                        title: Text(snapshot.data.documents[index]['name']),
                      ),
                      
                    );
                  }));
        },
      )
    

        ]),
      ),
    );
  }

 
   
      // StreamBuilder(
      //   stream: Firestore.instance
      //       .collection('course')
      //       .document(widget.data.documentID)
      //       .collection('section')
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) return const Text("Loading...");
      //     return Expanded(
      //         child: ListView.builder(
      //             itemCount: snapshot.data.documents.length,
      //             itemBuilder: (context, index) {
      //               //return buildListItem(context, snapshot.data.documents[index]);

      //               return Card(
      //                 child: ExpansionTile(
      //                   title: Text(snapshot.data.documents[index]['name']),
      //                 ),
                      
      //               );
      //             }));
      //   },
      // );
    
  

//   void _onclicked() {
//     firestoreInstance.collection("users").getDocuments().then((querySnapshot) {
//       querySnapshot.documents.forEach((result) {
//         print(result.data);
//       });
//     });
//   }
// }

  void _onDressed() {
    // Firestore.instance.collection("users").getDocuments().then((querySnapshot) {
    //   querySnapshot.documents.forEach((result) {
    Firestore.instance
        .collection("Plants")
        .document("Chillies")
        .collection("Tasks")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        print(result.data);
      });
    });
  }
}
