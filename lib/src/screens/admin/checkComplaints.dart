import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../crud.dart';

class CheckComplaints extends StatefulWidget {
  @override
  _CheckComplaintsState createState() => _CheckComplaintsState();
}

class _CheckComplaintsState extends State<CheckComplaints> {
  var complaint;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getComplaintData().then((results) {
      setState(() {
        complaint = results;
      });
    });
    super.initState();
  }

  navigateToDetail(DocumentSnapshot complaint) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
              complaint: complaint,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complaints",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: _complaintList(),
    );
  }

  Widget _complaintList() {
    if (complaint != null) {
      return StreamBuilder(
        stream: complaint,
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
                  onTap: () => navigateToDetail(snapshot.data.documents[i]),
                  onLongPress: (){
                    _showMaterialDialog(snapshot.data.documents[i].documentID);
                  },
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

  void _showMaterialDialog(String a) {
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
                      height: 70,
                      width: 70,
                      // color: Colors.green,
                      child: Icon(Icons.delete_outline,color: Colors.green,size: 70,),
                    ),
                    SizedBox(height: 20,),
                    Text("Do you want to Delete complaint",style: TextStyle(
                        fontSize: 15),),
                  ],
                ),

              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    crudObj.deleteData(a);
                    Navigator.pop(context);
                  },
                  child: Text('Yes')),

              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),

            ],
          );
        });
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot complaint;

  DetailPage({this.complaint});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.complaint.data['user Name'],
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'User Name',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.green),
                    ),
                    Text(
                      widget.complaint.data['user Name'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17.0,
                      ),
                    ),

                    SizedBox(height: 10.0,),
                    Text(
                      'User Contact',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.green),
                    ),
                    Text(
                      widget.complaint.data['User Contact'],
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
                    ),

                    SizedBox(height: 10.0,),
                    Text(
                      'User Address',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.green),
                    ),
                    Text(
                      widget.complaint.data['User Address'],
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
                    ),

                    SizedBox(height: 10.0,),
                    Text(
                      'Complaint Date',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.green),
                    ),
                    Text(
                      widget.complaint.data['Date'],
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
                    ),

                    SizedBox(height: 20.0,),
                    Text(
                      'Complaint Details',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.green),
                    ),
                    Text(
                      widget.complaint.data['Complaint Details'],
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }


}
