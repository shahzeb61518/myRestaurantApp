import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/pages/cart.dart';
import 'package:food_app_flutter_zone/src/pages/complaintBox.dart';
import 'package:food_app_flutter_zone/src/pages/sigin_page.dart';
import '../pages/home_page.dart';
import 'admin/adminDashboard.dart';
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
      appBar: AppBar(
        title: Text("Resturent App"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartPage()));
                },
                child: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      drawer: Stylishdrawer(),
      body:HomePage(),
    );
  }

  Widget Stylishdrawer() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0)),
        ),
        width: MediaQuery.of(context).size.width - 80,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
//            Container(
//              decoration: BoxDecoration(
//              //  borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
//                // color: Colors.blue.withOpacity(0.5)
//              ),
//            ),

            Container(
                child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("Restaurant"),
                  accountEmail: Text("smeuk.restaurantapp@gmail.com"),
                  currentAccountPicture: GestureDetector(
                      child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(37.0),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage('assets/images/beer.png'),
                          fit: BoxFit.cover,
                        )),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/background.jpg",
                        ),
                        fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6),BlendMode.darken )),
                  ),
                ),

                // Drawer body
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>SignInPage()));
                  },
                  child: ListTile(
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Icon(Icons.home, color: Colors.green),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminSignIn()));
                  },
                  child: ListTile(
                    title: Text(
                      "Admin",
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Icon(
                      Icons.perm_identity,
                      color: Colors.green,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/userProfile');
                  },
                  child: ListTile(
                    title: Text(
                      "My Profile",
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Icon(Icons.person_pin, color: Colors.green),
                  ),
                ),

                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/complaintBox');
                  },
                  child: ListTile(
                    title: Text(
                      "Complaint Box",
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Icon(Icons.message, color: Colors.green),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //Navigator.of(context).pushNamed('/complaintBox');
                  },
                  child: ListTile(
                    title: Text(
                      "Contact Us",
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Icon(Icons.contact_phone, color: Colors.green),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboard()));
                  },
                  child: ListTile(
                    title: Text(
                      "About Us",
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Icon(Icons.info_outline, color: Colors.green),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

