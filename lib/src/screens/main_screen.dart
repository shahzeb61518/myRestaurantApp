import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/pages/home_page.dart';

import 'admin/adminSignin.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body:HomePage(),
    );
  }
}

