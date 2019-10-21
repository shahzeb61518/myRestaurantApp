 import 'dart:io';
 import 'dart:async';
 import 'dart:math';
 import 'package:flutter/material.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:image_picker/image_picker.dart';
 import 'package:firebase_storage/firebase_storage.dart';
 import 'package:path/path.dart';

import 'adminDashboard.dart';

 class AddProducts extends StatefulWidget {
   @override
   _AddProductsState createState() => _AddProductsState();
 }

 class _AddProductsState extends State<AddProducts> {
   final formKey = GlobalKey<FormState>();


   String filename;
   File sampleImage;
   var imageUrl;

   Future getImage() async {
     var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

     setState(() {
       sampleImage = tempImage;
       filename = basename(sampleImage.path);
     });
   }

   @override
   void initState() {
//     imageUrl = url;
     super.initState();
   }


   Future<void> uploadImg(BuildContext context) async{

     StorageReference ref = FirebaseStorage.instance.ref().child(filename);
     StorageUploadTask uploadTask = ref.putFile(sampleImage);

     var downUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
     var url = downUrl.toString();

     print('download url : $url');
     Firestore.instance.collection('Add Products').add({
       'dish Name': _dishName,
       'rating': _rating,
       'Price': "\$ "+_price,
       'category': _currentCategoryItemSelected,
       'image Url': url,
     }).then((value){
       Navigator.of(context).pop();
       Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboard()));
       print('added');
     }).catchError((e) {
       print(e);
     });

   }

   var _categories = ['Starter','Biryani','BBQ','Naan', 'Tandoori', 'Vegetables','Sea Food','Pathia Dishes', 'Poultry Dishes', 'Rice','Balti Dishes', 'Raj Bhajan'];

   var _currentCategoryItemSelected = 'Tandoori';

   String _dishName;
   String _rating;
   var _price;

   var category;

   bool validateAndSave() {
     final form = formKey.currentState;
     if (form.validate()) {
       form.save();
       return true;
     } else {
       return false;
     }
   }

   void validateAndSubmit(BuildContext context) {
     if (validateAndSave()) {
       print("before apload image $url");
      uploadImg(context);
       print("after apload image $imageUrl");

     } else {
       print("error is occured");
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(
           "Add Product",
           style: TextStyle(
             fontFamily: 'Montserrat',
           ),
         ),
         backgroundColor: Colors.green,
         elevation: 0.1,
       ),
       body: ListView(
         children: <Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Stack(
                 children: <Widget>[
                   Container(
                     height: 130.0,
                     width: double.infinity,
                     color: Colors.green,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 20.0),
                     child: Center(
                       child: Column(
                         children: <Widget>[
                           Text(
                             "Create Product*",
                             style: TextStyle(
                               fontSize: 25.0,
                               fontFamily: 'Montserrat',
                               color: Colors.black54,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 15.0),
               Container(
                 width: double.infinity,
                 child: Form(
                   key: formKey,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                     child: Column(
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(
                               top: 5.0, left: 4.0, right: 4.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Text(
                                 "Food Name",
                                 style: TextStyle(
                                   color: Colors.teal,
                                   fontSize: 18.0,
                                   fontFamily: 'Montserrat',
                                 ),
                               ),
                               SizedBox(width: 10.0),
                               Text(
                                 "",
                                 style: TextStyle(
                                     color: Colors.teal, fontSize: 17.0),
                               ),
                             ],
                           ),
                         ),
                         TextFormField(
                           keyboardType: TextInputType.emailAddress,
                           keyboardAppearance: Brightness.dark,
                           decoration: InputDecoration(
                             hintText: 'Enter Dish name here....',
                             hintStyle:
                                 TextStyle(fontSize: 17.0, color: Colors.grey),
                             contentPadding: EdgeInsets.all(10.0),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0),
                             ),
                           ),
                           style: TextStyle(
                             fontSize: 20.0,
                           ),
                           validator: (value) => value.isEmpty
                               ? "Dish Name can't be Empty"
                               : null,
                           onSaved: (value) {
                             _dishName = value;
                           },
                         ),
                         SizedBox(
                           height: 10.0,
                         ),
                         Padding(
                           padding: const EdgeInsets.only(
                               top: 5.0, left: 4.0, right: 4.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Text(
                                 "Rating",
                                 style: TextStyle(
                                   color: Colors.green,
                                   fontSize: 18.0,
                                   fontFamily: 'Montserrat',
                                 ),
                               ),
                               SizedBox(width: 10.0),
                               Text(
                                 "",
                                 style: TextStyle(
                                     color: Colors.teal, fontSize: 17.0),
                               ),
                             ],
                           ),
                         ),
                         TextFormField(
                           keyboardType: TextInputType.number,
                           keyboardAppearance: Brightness.dark,
                           decoration: InputDecoration(
                             hintText: 'Rate here (1-5)....',
                             hintStyle: TextStyle(
                               fontSize: 17.0,
                               color: Colors.grey,
                             ),
                             contentPadding: EdgeInsets.all(10.0),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0),
                             ),
                           ),
                           style: TextStyle(
                             fontSize: 20.0,
                           ),
                           validator: (value) =>
                               value.isEmpty ? "Rate can't be Empty" : null,
                           onSaved: (value) {
                             _rating = value;
                           },
                         ),
                         SizedBox(
                           height: 10.0,
                         ),
                         Padding(
                           padding: const EdgeInsets.only(
                               top: 5.0, left: 4.0, right: 4.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Text(
                                 "Food Price",
                                 style: TextStyle(
                                   color: Colors.teal,
                                   fontSize: 18.0,
                                   fontFamily: 'Montserrat',
                                 ),
                               ),
                               SizedBox(width: 10.0),
                               Text(
                                 "",
                                 style: TextStyle(
                                     color: Colors.teal, fontSize: 17.0),
                               ),
                             ],
                           ),
                         ),
                         TextFormField(
                           keyboardType: TextInputType.number,
                           keyboardAppearance: Brightness.dark,
                           decoration: InputDecoration(
                             hintText: 'Enter Food Price here....',
                             hintStyle:
                                 TextStyle(fontSize: 17.0, color: Colors.grey),
                             contentPadding: EdgeInsets.all(10.0),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0),
                             ),
                           ),
                           style: TextStyle(
                             fontSize: 20.0,
                           ),
                           validator: (value) => value.isEmpty
                               ? "Food Price can't be Empty"
                               : null,
                           onSaved: (value) {
                             _price = value;
                           },
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[

                             SizedBox(
                               width: 2.0,
                             ),
                             Container(
                               height: 40.0,
                               width: MediaQuery.of(context).size.width *91 /100,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5.0),
                                   border: Border.all(
                                       width: 1.0, color: Colors.grey)),
                               padding: EdgeInsets.all(10.0),
                               child: DropdownButton<String>(
                                 items: _categories
                                     .map((String dropDownStringItem) {
                                   return DropdownMenuItem<String>(
                                     value: dropDownStringItem,
                                     child: Text(dropDownStringItem),
                                   );
                                 }).toList(),
                                 onChanged: (String newValueSelected) {
                                   setState(() {
                                     this._currentCategoryItemSelected =
                                         newValueSelected;
                                   });
                                 },
                                 value: _currentCategoryItemSelected,
                               ),
                             ),
                           ],
                         ),
                         SizedBox(
                           height: 10.0,
                         ),
                         Container(
                           height: 300.0,
                           width: double.infinity,
                           child: sampleImage == null
                               ? Text('Select an image')
                               : enableUpload(),
                         ),
                         SizedBox(height: 10.0),
                         Padding(
                           padding: const EdgeInsets.only(
                               left: 1.0, right: 1.0, bottom: 10.0),
                           child: Container(
                             height: 40.0,
                             child: Material(
                               borderRadius: BorderRadius.circular(5.0),
                               shadowColor: Colors.green,
                               color: Colors.green,
                               elevation: 7.0,
                               child: InkWell(
                                 child: Center(
                                   child: Text(
                                     "SELECT IMAGE",
                                     style: TextStyle(
                                       fontFamily: 'Montserrat',
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17.0,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                                 onTap: getImage,
                               ),
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(
                               left: 1.0, right: 1.0, bottom: 20.0),
                           child: Container(
                             height: 40.0,
                             child: Material(
                               borderRadius: BorderRadius.circular(5.0),
                               shadowColor: Colors.green,
                               color: Colors.green,
                               elevation: 7.0,
                               child: InkWell(
                                 child: Center(
                                   child: Text(
                                     "SUBMIT",
                                     style: TextStyle(
                                       fontFamily: 'Montserrat',
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17.0,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                                 onTap: (){
                                   validateAndSubmit(context);
                                 },
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ],
           )
         ],
       ),
     );
   }

   Widget enableUpload() {
     return Container(
       child: Column(
         children: <Widget>[
           Image.file(
             sampleImage,
             height: 300.0,
             width: 300.0,
           ),
         ],
       ),
     );
   }
 }
