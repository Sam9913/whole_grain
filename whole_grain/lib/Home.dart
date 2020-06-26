import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarc/DietIntake.dart';
import 'Product.dart';
import 'Search.dart';
import 'VerticalList.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String email = "";

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  getEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DocumentSnapshot documentSnapshot = await Firestore.instance.collection("user").document(prefs
        .getString("token")).get();

    setState(() {
      email = documentSnapshot["email"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.greenAccent,

        // Define the default font family.
        fontFamily: 'Arial',
      ),
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Your current acccount email:'),
                    Text(email,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                ),
              ),
              ListTile(
                title: Text('Reset'),
                onTap: () {

                },
              ),
              ListTile(
                title: Text('Log Out'),
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  Login()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DietIntake()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('product_type').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Loading...");
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds_type = snapshot.data.documents[index];
                    DocumentReference dr = Firestore.instance
                        .collection('product_type')
                        .document(ds_type.documentID);
                    return ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(ds_type['Name'].toString()),
                              new InkWell(
                                onTap: () =>
                                    _showAll(
                                        dr, ds_type['Name'].toString(), context),
                                child: new Text(
                                  "Show All",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Container(
                            height: 200,
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('product')
                                    .where('product_type', isEqualTo: dr)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Text("Loading...");
                                  return new ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot ds =
                                        snapshot.data.documents[index];
                                        //return new Text(ds['product_name'].toString());
                                        return new Product(
                                          index: index,
                                          product_name:
                                          ds['product_name'].toString(),
                                          image_url: ds['image'].toString(),
                                        );
                                      });
                                })));
                  });
            }),
      ),
    );
  }

  void _showAll(DocumentReference documentReference, String product_type, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            VerticalList(
              documentReference: documentReference,
              product_type: product_type,
            )));
  }

}