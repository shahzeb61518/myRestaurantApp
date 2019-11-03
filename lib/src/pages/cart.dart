import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/pages/sigin_page.dart';
import 'package:food_app_flutter_zone/src/screens/main_screen.dart';
import 'package:food_app_flutter_zone/src/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../crud.dart';
import '../../listDetailPage.dart';

const double _leftColumnWidth = 60.0;

class ShoppingCartPage extends StatefulWidget {
  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {

  var ordersData;

  crudMedthods crudObj = new crudMedthods();
 //  var path = snapshot.data.documents[i].documentID;
  double subTotal = 0;
  double total = 0;

  void calculate(){
    print(cartlist.length);
    for(int i=0; i<cartlist.length;i++){
      subTotal+=double.parse(cartlist[i].price);
    }
    setState(() {
      subTotal=subTotal;
      total=subTotal;
    });
  }


@override
  void initState() {
   // cals(0);
  calculate();
  crudObj.getOrdersData().then((results) {
    setState(() {
      ordersData = results;
    });
  });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData localTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      backgroundColor: kShrinePink50,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .65,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: cartlist.length,
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (context, i) {
                    return Card(
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 70,
                                width: 70,
                                child: Image.network(
                                  cartlist[i].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 10),
                                child: Text(
                                  cartlist[i].name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.only(left: 90, right: 20),
                              child: Text(
                                cartlist[i].price,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),

                            ),
                          ],
                        ),
                      ),
                    );

                  },

                ),

              ),

              Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(
                          "Sub Total", style: TextStyle(fontSize: 18),)),
                        Text('£$subTotal'),
                      ],
                    ),
                  ),

                  Divider(
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(
                          "Total", style: TextStyle(fontSize: 18),)),
                        Text("£${total.toString()}"),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        cartlist.removeRange(0, cartlist.length);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => ShoppingCartPage()));
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "CLEAR CART",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (cartlist.length <= 0) {
                          print("cart list is empty");
                        } else {
                          if (FirebaseAuth.instance.currentUser() != null) {
                            // signed in
                            print("user is signed in");
                            Firestore.instance.collection('/orders').add({
                              'Sub Total': subTotal,
                              'Total': total,
                              'Delievery Charges' : 0,
                              "accept" : false,
                            }).then((value) {
                              for(int i=0; i<cartlist.length;i++){
                                value.collection('food').add(
                                  {
                                    'name': cartlist[i].name,
                                    'price': cartlist[i].price,
                                    'image': cartlist[i].image,

                                   // 'category' : "food"
                                  }
                                );
                              //  subTotal+=int.parse(cartlist[i].price);
                              }
                            //  value.collection('food').add();
                              _showMaterialDialog();
                              print("values are uploaded");
                            }).catchError((e) {
                              print(e);
                            });
                          } else {
                            print("user is not signed in");
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignInPage()));
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "PROCEED",
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
              )
            ],
          )
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      // color: Colors.green,
                      child: Icon(
                        Icons.check_circle, color: Colors.green, size: 90,),
                    ),
                    SizedBox(height: 20,),
                    Text("Order Placed Successfully", style: TextStyle(
                        fontSize: 15),),
                  ],
                ),

              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    cartlist.removeRange(0, cartlist.length);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: Text('Done')),
            ],
          );
        });
  }
}


