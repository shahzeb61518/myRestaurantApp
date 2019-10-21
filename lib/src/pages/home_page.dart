import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import '../../listDetailPage.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Widget imageCarousel = new Container(
    height: 150.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/images/background.jpg'),
        AssetImage('assets/images/breakfast.jpeg'),
        AssetImage('assets/images/burger.png'),
        AssetImage('assets/images/lunch.jpeg'),
        AssetImage('assets/images/supper_1.jpeg'),
        AssetImage('assets/images/cupcake.png'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 4.0,
      dotColor: Colors.white,
      indicatorBgPadding: 2.0,
      dotBgColor: Colors.transparent,
      overlayShadow: true,
      autoplay: true,
      overlayShadowColors: Colors.black.withOpacity(0.8),
    ),
  );


  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Column(
        children: <Widget>[
          imageCarousel,

          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),

          Flexible(child: getListView()),

        ],
      ),
    );
  }

  List<ItemList> listitems = [

    ItemList('Starter', 'assets/images/lunch.jpeg'),
    ItemList('Tandoori', 'assets/images/turkey.png'),
    ItemList('Balti Dishes', 'assets/images/lunch.jpeg'),
    ItemList('Biryani', 'assets/images/lunch.jpeg'),
    ItemList('BBQ', 'assets/images/lunch.jpeg'),
    ItemList('Vagetable', 'assets/images/lunch.jpeg'),
    ItemList('Raj Vhanja', 'assets/images/background.jpg'),
    ItemList('Naan', 'assets/images/lunch.jpeg'),
    ItemList('Pathia Dishes', 'assets/images/background.jpg'),
    ItemList('Sea Food', 'assets/images/background.jpg'),
    ItemList('Poultry Dishes', 'assets/images/background.jpg'),
    ItemList('Rice', 'assets/images/background.jpg'),


  ];

  Widget getListView() {

    return ListView.builder(
        itemCount: listitems.length,
        itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (comtext)=>ListDetail(name:listitems[index].name)));
                },
                child: Material(
                  elevation: 9,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
//                    color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(listitems[index].image),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),

                        Center(
                          child: Text(listitems[index].name,style: TextStyle(color: Colors.white,fontSize: 30.0),),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),

          ],

        );
        });
  }
}
class ItemList{

  String name;
  String image;

  ItemList(this.name , this.image);
}