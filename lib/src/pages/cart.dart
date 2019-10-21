import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/widgets/colors.dart';

import '../../listDetailPage.dart';

const double _leftColumnWidth = 60.0;

class ShoppingCartPage extends StatefulWidget {
  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {

  int subTotal =0;
  var dalievery = 10;
  var total = 0;

  void sumUp(int a){
      subTotal += a;
    print(subTotal);
  }

  Widget totalSumUp(){
    total = subTotal+dalievery;
    print(total);
    return SizedBox(height: 0);
  }
  @override
  void initState() {

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
              height: MediaQuery.of(context).size.height*.68,
              width: double.infinity,
              child:  ListView.builder(
            itemCount: cartlist.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
              sumUp(int.parse(cartlist[i].price));
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
                totalSumUp(),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("Sub Total",style: TextStyle(fontSize: 18),)),
                      Text(subTotal.toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("Delievery",style: TextStyle(fontSize: 18),)),
                      Text("10"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("Total",style: TextStyle(fontSize: 18),)),
                      Text(total.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
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

}

