import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListDetail extends StatefulWidget {
  final name;

  ListDetail({Key key, this.name}) : super(key: key);

  @override
  _ListDetailState createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Add Products')
            .where('category', isEqualTo: widget.name)
            .snapshots(),
        //print an integer every 2secs, 10 times
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading..");
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Cartitem newItem = new Cartitem(
                        snapshot.data.documents[index].data['dish Name'],
                        snapshot.data.documents[index].data["Price"],
                        snapshot.data.documents[index].data['image Url'],
                        '1');
                    cartlist.add(newItem);

                  },
                  child: Card(
                    child: Container(
                      height: 90,
                      width: 90,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 90,
                              width: 90,
                              child: Image.network(
                                snapshot
                                    .data.documents[index].data['image Url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20),
                                  child: Text(
                                    snapshot
                                        .data.documents[index].data['dish Name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 20,
                                  width: 95,
                                 // color: Colors.green,
                                  child: Row(
                                    children: <Widget>[
                                      ratingbar(),
                                      Text("5.0"),
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 90, right: 20),
                                child: Text(
                                  snapshot.data.documents[index].data["Price"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Widget ratingbar() {
  return RatingBar(
    initialRating: 4.0,
    direction: Axis.horizontal,
    allowHalfRating: true,
    glowColor: Colors.white,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.green,
    ),

    //   onRating: (color:Colors.green) {
//        print(rating);
    // },
    itemSize: 15,

  );
}

class Cartitem {
  String name;
  String price;
  String image;
  String quantity;

  Cartitem(this.name, this.price, this.image, this.quantity);
}

List<Cartitem> cartlist = new List<Cartitem>();