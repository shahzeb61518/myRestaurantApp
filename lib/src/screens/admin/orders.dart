import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/pages/orderdetailpage.dart';
import '../../../crud.dart';
import '../../../listDetailPage.dart';
import 'orderCompleted.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var ordersData;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getOrdersData().then((results) {
      setState(() {
        ordersData = results;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contexr)=>CompletedOrders()));
                },
                splashColor: Colors.white,
                child: Icon(Icons.assignment_turned_in)),
          ),
        ],
      ),
      body: _usersList(),
    );
  }

  Widget _usersList() {
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
//                child: new ListTile(
////                  leading:Image.network(
////                      snapshot.data.documents[i].data['image Url']),
//                  leading: CircleAvatar(
//                    backgroundColor: Colors.green,
//                    child: Icon(Icons.perm_identity,color: Colors.white,),
//                  ),
//                  trailing: Icon(Icons.arrow_forward_ios),
//                  title: Text(snapshot.data.documents[i].data['Sub Total'].toString()),
//                  subtitle: Text(snapshot.data.documents[i].data['Total'].toString()),
//                  onLongPress: () {
//                    crudObj.deleteprofileData(snapshot.data.documents[i].documentID);
//                  },
//                ),

              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderdetailPage(snapshot.data.documents[i].documentID,snapshot.data.documents[i].data['Sub Total'],snapshot.data.documents[i].data['Total'].toString()))) ,
                  child: ListTile(
                    leading: Icon(Icons.assignment,color: Colors.green,),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text('Order  ${i+1}'),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  )


                    //  SizedBox(width: 20,),

                    //  InkWell(
                      //  onTap: ()=> _showMaterialDialog(snapshot.data.documents[i].documentID) ,
//                      child: Container(
//                        height: 40,
//                        width:40,
//
//                        child: CircleAvatar(
//                          child: Icon(Icons.check,color: Colors.white,),
//                        ),
//                      ),
                   //   ),
                    //  SizedBox(width: 20,),
//                    InkWell(
//                      onTap: ()=> crudObj.deleteorder(snapshot.data.documents[i].documentID),
//                      child: Container(
//                        height: 40,
//                        width:40,
//                        //color: Colors.red[400],
//                        child: CircleAvatar(
//                          backgroundColor: Colors.red[400],
//                          child: Icon(Icons.close,color: Colors.white,),
//                        ),
//                      ),
//                    ),


                ),
              ),
              );
            },
          );
        },
      );
    }



  }