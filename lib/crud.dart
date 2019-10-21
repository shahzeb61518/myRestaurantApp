import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  getData() async {
    return await Firestore.instance.collection('Add Products').snapshots();
  }

  getComplaintData() async {
    return await Firestore.instance.collection('Complaint Box').snapshots();
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Complaint Box')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteItemData(docId) {
    Firestore.instance
        .collection('Add Products')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }


  updateItemData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Add Products')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }



}
