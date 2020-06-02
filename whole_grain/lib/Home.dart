import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'Search.dart';
import 'VerticalList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
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
            return new ListView.builder(
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
                              onTap: () => _showAll(
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
    );
  }

  void _showAll(DocumentReference documentReference, String product_type, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VerticalList(
          documentReference: documentReference,
          product_type: product_type,
        )));
  }
}