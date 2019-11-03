import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/pages/sigin_page.dart';
import 'package:food_app_flutter_zone/src/screens/main_screen.dart';
import 'package:food_app_flutter_zone/src/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../crud.dart';
import '../../listDetailPage.dart';

const double _leftColumnWidth = 60.0;

class OrderdetailPage extends StatefulWidget {
  String docid;
  var subtotal;
  var total;
  OrderdetailPage(this.docid,this.subtotal,this.total);
  @override
  OrderdetailPageState createState() => OrderdetailPageState();
}

class OrderdetailPageState extends State<OrderdetailPage> {

  var ordersData;

  crudMedthods crudObj = new crudMedthods();
  int subTotal = 0;
  var total = 0;

//  void calculate(){
//    print(cartlist.length);
//    for(int i=0; i<cartlist.length;i++){
//      subTotal+=int.parse(cartlist[i].price);
//    }
//    setState(() {
//      subTotal=subTotal;
//      total=subTotal;
//    });
//  }


  @override
  void initState() {
    crudObj.detOrderDetail(widget.docid).then((results) {
      setState(() {
        ordersData = results;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  Widget _orderdetaillist() {
    return StreamBuilder(
      stream: ordersData,
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, i) {
            return Card(
                child: new ListTile(
                 leading:Image.network(
                      snapshot.data.documents[i].data['image']),


                  title: Text(snapshot.data.documents[i].data['name'].toString()),
                  trailing: Text(snapshot.data.documents[i].data['price'].toString()),

                ),

//              child: Container(
//                height: 60,
//                width: MediaQuery.of(context).size.width,
//                child: InkWell(
//                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderdetailPage(snapshot.data.documents[i].documentID))) ,
//                    child: ListTile(
//                      leading: Icon(Icons.assignment,color: Colors.green,),
//                      title: Padding(
//                        padding: const EdgeInsets.only(left: 12),
//                        child: Text('Order  ${i+1}'),
//                      ),
//                      trailing: Icon(Icons.arrow_forward_ios),
//                    )
//
//
//                ),
//              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData localTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
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
               child: _orderdetaillist(),

              ),

              Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(
                          "Sub Total", style: TextStyle(fontSize: 18),)),
                        Text('£${widget.subtotal}'),
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
                        Text("£${widget.total}"),
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
                      onTap: () {_showMaterialDialog(widget.docid);
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "ACCEPT",
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
                        crudObj.deleteorder(widget.docid);
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "REJECT",
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
  void _showMaterialDialog(String docid) {
    //  TextEditingController delieverychargesCon = TextEditingController();
    String delieveryCharege;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    // delieverycharges;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Form(
              key: formKey,
              child: Padding(
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
                      Text("Enter Delievery Charges", style: TextStyle(
                          fontSize: 15),),
                      SizedBox(height: 10,),


                      TextField(
//                        validator: (value) => value.isEmpty
//                            ? "Delievry charges can't be Empty"
//                            : null,
                        onChanged: (value) {
                          //   delieverychargesCon = input as TextEditingController;
                          delieveryCharege = value;
                        },
                        keyboardType: TextInputType.numberWithOptions(decimal: false),)
                    ],
                  ),

                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (!delieveryCharege.isEmpty) {
                      Navigator.pop(context);
                      // crudObj.updateOrderData(, )
                      print(delieveryCharege);
                      crudObj.updateOrderData(docid, {
                        'Delievery Charges': delieveryCharege,
                        'accept': true
                      }).then((result) {
                        // dialogTrigger(context);
                        print("this is then part of update");
                      }).catchError((e) {
                        print(e);
                      });
                      setState(() {
                        total=(total + int.parse(delieveryCharege) ) ;
                      });
                    }else{
                      showSnackBar(context, "Delievery Charges Can't be Empty");
                    }

                  },
                  child: Text('Done')),
            ],
          );
        });
  }

}


