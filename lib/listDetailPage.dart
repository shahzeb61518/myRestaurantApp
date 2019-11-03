import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app_flutter_zone/src/pages/cart.dart';

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
        actions: <Widget>[
          InkWell(
            onTap: () {

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.add_shopping_cart),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Add Products')
            .where('category', isEqualTo: widget.name)
            .snapshots(),
        //print an integer every 2secs, 10 times
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showSnackBar(context,snapshot.data.documents[index].data['dish Name'] );
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
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: snapshot
                                  .data.documents[index].data['image Url'],
                               // placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    snapshot.data.documents[index]
                                        .data['dish Name'],
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
void showSnackBar(BuildContext context , String value){
  var snackbar = SnackBar(content: Text('$value  is selected'));
  Scaffold.of(context).showSnackBar(snackbar);
}
//Widget ratingbar() {
//  return RatingBar(
//    initialRating: 4.0,
//    direction: Axis.horizontal,
//    allowHalfRating: true,
//    glowColor: Colors.white,
//    itemCount: 5,
//    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
//    itemBuilder: (context, _) => Icon(
//      Icons.star,
//      color: Colors.green,
//    ),
//
//    //   onRating: (color:Colors.green) {
////        print(rating);
//    // },
//    itemSize: 15,
//  );
//}

class Cartitem {
  String name;
  String price;
  String image;
  String quantity;

  Cartitem(this.name, this.price, this.image, this.quantity);




}

List<Cartitem> cartlist = new List<Cartitem>();
