import 'package:flutter/material.dart';

import 'orderCompleted.dart';
import 'orders.dart';

class OrderManagment extends StatefulWidget {

  @override
  _OrderManagmentState createState() => _OrderManagmentState();
}

class _OrderManagmentState extends State<OrderManagment>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: Icon(Icons.arrow_back_ios),
        backgroundColor: Colors.green,
        bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.teal,
            tabs: [
              Tab(
                child: Text(
                  'Orders',
                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  'Completed Orders',
                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
         Orders(),
         CompletedOrders(),
        ],
      ),
    );
  }
}
