import 'package:cloud_firestore/cloud_firestore.dart';

class Useredits{
  final Firestore _firestore = Firestore.instance;



  editUser(data, documentId) {
    _firestore
        .collection('users')
        .document(documentId)
        .updateData(data);
  }

  
}
