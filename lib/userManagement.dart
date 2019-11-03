import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app_flutter_zone/src/screens/admin/addProduct.dart';

class UserManagement{

  storeNewUser(user,context,firstname,lastname) {
    String role = "user";
    print('in user manaaaage class');
    print(user);
    print(user.uid.toString());
    print(user.email);

    Firestore.instance.collection('users').document().setData({
      'firstname': firstname,
      'lastname': lastname,
      'email': user.email,
      'uid': user.uid,
      'role': role,

    });
    // {
      showSnackBar(context, 'User Registered Successfully');
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/homePage');
  }

  userAuthorizationAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('/users')
          .where('uid' , isEqualTo: user.uid)
          .getDocuments()
          .then((docs){
        if(docs.documents[0].exists){
          if(docs.documents[0].data['role'] == 'admin'){
//            Navigator.of(context).push(MaterialPageRoute(
//                builder: (BuildContext context)=> AdminDashboard()));
          }else{
      //      showSnackBar(context, "you are not authorized to access this page");
          }
        }else{
         showSnackBar(context, 'Oops invalid Email or Password');
        }
      });
    });
  }

  void showSnackBar(BuildContext context , String value){
    var snackbar = SnackBar(content: Text(value));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}