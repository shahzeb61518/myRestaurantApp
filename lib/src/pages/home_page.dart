import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:food_app_flutter_zone/src/pages/sigin_page.dart';
import 'package:food_app_flutter_zone/src/pages/signup_page.dart';
import 'package:food_app_flutter_zone/src/screens/admin/adminDashboard.dart';
import 'package:food_app_flutter_zone/src/screens/admin/adminSignin.dart';

import '../../listDetailPage.dart';
import 'cart.dart';
import 'orderdetailpage.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Widget imageCarousel = new Container(
    height: 150.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [


        AssetImage('assets/images/lunch.jpeg'),
        AssetImage('assets/images/supper_1.jpeg'),
        AssetImage('assets/carosil/1.jpg'),
        AssetImage('assets/carosil/2.jpg'),
        AssetImage('assets/carosil/3.jpg'),
        AssetImage('assets/carosil/4.jpg'),
        AssetImage('assets/images/breakfast.jpeg'),
        AssetImage('assets/carosil/5.jpg'),
        AssetImage('assets/carosil/6.jpg'),
        AssetImage('assets/carosil/7.jpg'),
        AssetImage('assets/carosil/8.jpg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 4.0,
      dotColor: Colors.white,
      indicatorBgPadding: 2.0,
      dotBgColor: Colors.transparent,
      overlayShadow: true,
      autoplay: true,
      overlayShadowColors: Colors.black.withOpacity(0.8),
    ),
  );

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
                        Navigator.push(context, MaterialPageRoute(builder: (contex)=>HomePage()));
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
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignInPage()));
                      },
                      child: ListTile(
                        title: Text(
                          "Sign In",
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminDashboard()));
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
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
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

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Resturent App"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartPage()));
                },
                child: Icon(Icons.add_shopping_cart)),
          ),
        ],
      ),
      drawer: Stylishdrawer(),
      body: Column(
        children: <Widget>[
          imageCarousel,

          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),

          Flexible(child: getListView()),

        ],
      ),
    );
  }

  List<ItemList> listitems = [

    ItemList('Starter', 'assets/images/MENU/Starter.jpg'),
    ItemList('Tandoori', 'assets/images/MENU/Tandoori.jpg'),
    ItemList('Balti Dishes', 'assets/images/MENU/Balti Dishes.jpg'),
    ItemList('Biryani', 'assets/images/MENU/Biryani Dishes.jpg'),
    ItemList('Lamb', 'assets/images/MENU/Lamb.jpg'),
    ItemList('Vagetables', 'assets/images/MENU/Vegetables.jpg'),
    ItemList('New Hash Dishes', 'assets/images/MENU/New Hash Dishes.jpeg'),
    ItemList('Sundries', 'assets/images/MENU/Sundries.jpg'),
    ItemList('Rice', 'assets/images/MENU/Rice.jpg'),

  ];

  Widget getListView() {

    return ListView.builder(
        itemCount: listitems.length,
        itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (comtext)=>ListDetail(name:listitems[index].name)));
                },
                child: Material(
                  elevation: 9,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
//                    color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(listitems[index].image),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),

                        Center(
                          child: Text(listitems[index].name,style: TextStyle(color: Colors.white,fontSize: 25.0),),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),

          ],

        );
        });
  }
}
class ItemList{

  String name;
  String image;

  ItemList(this.name , this.image);
}