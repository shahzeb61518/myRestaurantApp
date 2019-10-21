import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../userManagement.dart';
import 'adminDashboard.dart';

class AdminSignIn extends StatefulWidget {
  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {


  final formkey = GlobalKey<FormState>();
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formkey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password)
          .then((user) {
//        UserManagement().adminAuthorizationAccess(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context)=> AdminDashboard()));
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error occured");
    }
  }
  bool _toggleVisibility = true;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      validator: (value) =>
      value.isEmpty ? "email can't be Empty" : null,
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      validator: (value) =>
      value.isEmpty ? "password can't be Empty" : null,
      onSaved: (value) {
        _password = value;
      },
      obscureText: _toggleVisibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.cover,
                    )),

                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.7),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: 110.0,
                      ),

                      Form(
                        key: formkey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5.0,
                            color: Colors.white.withOpacity(0.3),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  _buildEmailTextField(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _buildPasswordTextField(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      InkWell(
                        onTap: validateAndSubmit,
                        child: Container(
                          height: 40,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
