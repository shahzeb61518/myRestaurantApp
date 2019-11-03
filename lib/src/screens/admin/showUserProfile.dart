import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../crud.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var profile;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getUserProfileData().then((results) {
      setState(() {
        profile = results;
      });
    });
    super.initState();
  }

  navigateToDetail(DocumentSnapshot complaint) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
              data: complaint,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: _usersList(),
    );
  }

  Widget _usersList() {

      return StreamBuilder(
        stream: profile,
        builder: (context, snapshot) {
           if(!snapshot.hasData)
             Center(child: CircularProgressIndicator());
         return  ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return Card(
                child: new ListTile(
//                  leading:Image.network(
//                      snapshot.data.documents[i].data['image Url']),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.perm_identity,color: Colors.white,),
                ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(snapshot.data.documents[i].data['email']),
                  subtitle: Text(snapshot.data.documents[i].data['role']),
                  onTap: () => navigateToDetail(snapshot.data.documents[i]),
                  onLongPress: () {
                    _showMaterialDialog(snapshot.data.documents[i].documentID);
                  },
                ),
              );
            },
          );
        },
      );

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
                    Text("Do you want to Delete User",style: TextStyle(
                        fontSize: 15),),
                  ],
                ),

              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    crudObj.deleteprofileData(a);
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
  final DocumentSnapshot data;

  DetailPage({this.data});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.data['email'],
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
//        color: Colors.green.withOpacity(0.1),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 30),
          child: Card(
            color: Colors.white.withOpacity(0.8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      height: 180.0,
                      width: 180.0,
//                    child: Image.network(
//                        widget.data.data['image Url']),
                    child: Icon(Icons.person_pin,size: 90,color: Colors.green,),
                    ),

                    SizedBox(height: 20.0,),
                    Text(
                      ' Name',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          color: Colors.green),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      widget.data.data['email'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          color: Colors.green),
                    ),
                    Text(
                      widget.data.data['role'],
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
