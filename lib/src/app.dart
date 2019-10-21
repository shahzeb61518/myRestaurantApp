import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/pages/complaintBox.dart';
import 'package:food_app_flutter_zone/src/pages/home_page.dart';
import 'package:food_app_flutter_zone/src/pages/profile_page.dart';
import 'package:food_app_flutter_zone/src/screens/admin/addProduct.dart';
import 'package:food_app_flutter_zone/src/screens/admin/adminSignin.dart';
import 'screens/main_screen.dart';
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food Delivery App",
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => HomePage(),
        '/adminSignIn': (BuildContext context) => AdminSignIn(),
        '/complaintBox': (BuildContext context) => ComplaintBox(),
        '/addProducts': (BuildContext context) => AddProducts(),
        '/userProfile': (BuildContext context) => ProfilePage(),
      },
      home: MainScreen(),
    );
  }
}