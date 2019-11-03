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

  getOrdersData() async {
    return await Firestore.instance.collection('orders').where("accept",isEqualTo: false).snapshots();
  }

  detOrderDetail(String docid) async {
    return await Firestore.instance.collection('orders').document(docid).collection('food').snapshots();
  }

  getAcceptedOrdersData() async {
    return await Firestore.instance.collection('orders').where("accept",isEqualTo: true).snapshots();
  }

  getUserProfileData() async {
    return await Firestore.instance.collection('users').snapshots();
  }

  deleteprofileData(docId) {
    Firestore.instance
        .collection('users')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteorder(docId) {
    Firestore.instance
        .collection('orders')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteOrdersData(docId) {
    Firestore.instance
        .collection('orders')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
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

  updateOrderData(selectedDoc, newValues) {
    Firestore.instance
        .collection('orders')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }



}
