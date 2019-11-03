import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/screens/admin/showUserProfile.dart';

import 'addProduct.dart';
import 'checkComplaints.dart';
import 'orders.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0.3,
      ),

// ADMIN DRAWER STARTS FROM HERE

      body: Stack(
        children: <Widget>[
          Container(
            height: 220.0,
            width: double.infinity,
            // color: Colors.teal,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.darken),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Text(
              'Resturen App',
              style: TextStyle(
                  fontSize: 30.0, color: Colors.white.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 140.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: TheGridView().build(context),
            ),
          )
        ],
      ),
    );
  }
}

class TheGridView {
  Card makeGridCell(String name, String image) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                    height: 60.0,
                    width: 60.0,
                    child: Center(child: Image.asset(image))),
              ),
              SizedBox(height: 10.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          )
        ],
      ),
    );
  }

  GridView build(BuildContext context) {
    return GridView.count(
      primary: true,
      padding: EdgeInsets.all(18.0),
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 6.0,
      children: <Widget>[
        InkWell(
          child: makeGridCell("Products", 'assets/images/addproducts.png'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddProducts()));
          },
        ),
        InkWell(
          child: makeGridCell("Users", 'assets/images/users.ico'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => UserProfile()));
          },
        ),
        InkWell(
          child: makeGridCell("Orders", 'assets/images/ecommerce.png'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Orders()));
            }
        ),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CheckComplaints()));
          },
          child: makeGridCell("Complaint Box", 'assets/images/complaint.png'),
        ),
      ],
    );
  }
}
