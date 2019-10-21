import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app_flutter_zone/src/screens/main_screen.dart';

class ComplaintBox extends StatefulWidget {
  @override
  _ComplaintBoxState createState() => _ComplaintBoxState();
}

class _ComplaintBoxState extends State<ComplaintBox> {
  final formKey = GlobalKey<FormState>();

  String _userName;

  String _userContact;
  String _userAddress;
  String _complaintDetails;

  String _date = DateTime.now().toString();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      Firestore.instance.collection('Complaint Box').add({
        'user Name': _userName,
        'User Contact': _userContact,
        'User Address': _userAddress,
        'Complaint Details': _complaintDetails,
        'Date': _date,
      }).then((value){
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
        print('added');
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is occured");
    }
  }

  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 3), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complaint Box",
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0.5,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(top: 20),
//                child: Container(
//                  height: 50,
//                  width: double.infinity,
//                  child: Center(
//                    child: Text(
//                      "Complaint Section",
//                      style: TextStyle(fontSize: 20, color: Colors.black),
//                    ),
//                  ),
//                ),
//              ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "User Name",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter user name here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) =>
                              value.isEmpty ? "UserName can't be Empty" : null,
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "User Contact",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter contact here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) => value.isEmpty
                              ? "User Contact can't be Empty"
                              : null,
                          onSaved: (value) {
                            _userContact = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "User Address",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter your Address here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) =>
                              value.isEmpty ? "Address can't be Empty" : null,
                          onSaved: (value) {
                            _userAddress = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Complaint Details",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter Details Here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          maxLines: 3,
                          validator: (value) =>
                              value.isEmpty ? "Name can't be Empty" : null,
                          onSaved: (value) {
                            _complaintDetails = value;
                          },
                        ),
                        SizedBox(height: 25.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Note : Any illegal materials uploaded User will be responsible for that ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 20.0),
                          child: Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(5.0),
                              shadowColor: Colors.green,
                              color: Colors.green,
                              elevation: 7.0,
                              child: InkWell(
                                onTap: validateAndSubmit,
                                child: Center(
                                  child: Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
