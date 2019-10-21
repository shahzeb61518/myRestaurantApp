import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: getListView(),
      ),
    );
  }

  List<ItemClass> allItems = [
    ItemClass('Daily Deals','Big discounts on top items! Updated daily','images/nowifi.png'),
    ItemClass('Weekly Best Sellers','The best sold products of the week','images/nowifi.png'),
    ItemClass('Gift Sets','The perfect gifts for every occasion','images/nowifi.png'),
    ItemClass('Clearance','ISD clearance sale','images/nowifi.png'),
    ItemClass('Renewed Gadgets','Refurbished Items','images/nowifi.png'),

  ];

  Widget getListView() {
    return ListView.builder(
        itemCount: allItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 6.0,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 5),
              leading: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Container(
                  height: 50,
                  width: 60,
                  // color: Colors.grey.withOpacity(0.3),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Image.asset(allItems[index].image),
                  ),
                ),
              ),
              title: Text(allItems[index].title),
              subtitle: Text(allItems[index].subtitle),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        });

  }
}

class ItemClass {
  String title,subtitle;
  String image;

  ItemClass(this.title,this.subtitle,this.image);

}