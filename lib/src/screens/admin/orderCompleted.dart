import 'package:flutter/material.dart';

import '../../../crud.dart';

class CompletedOrders extends StatefulWidget {
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  var acceptedordersData;

  crudMedthods crudObj = new crudMedthods();
  @override
  void initState() {
    // TODO: implement initState
    crudObj.getAcceptedOrdersData().then((results) {
      setState(() {
        acceptedordersData = results;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accepted Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Center(
          child: Text('Completed Order'),
        )
      ),
    );
  }


  Widget _acceptedOrderList() {
    if (acceptedordersData != null) {
      return StreamBuilder(
        stream: acceptedordersData,
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return Card(
                child: new ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.perm_identity,color: Colors.white,),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(snapshot.data.documents[i].data['user Name']),
                  subtitle: Text(snapshot.data.documents[i].data['User Contact']),
//                  onTap: () => navigateToDetail(snapshot.data.documents[i]),
//                  onLongPress: (){
//                    _showMaterialDialog(snapshot.data.documents[i].documentID);
//                  },
                ),
              );
            },
          );
        },

      );
    } else {
      return Text('Loading, Please wait..');
    }
  }

}