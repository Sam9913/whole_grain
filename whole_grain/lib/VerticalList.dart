
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarc/ProductDetails.dart';

class VerticalList extends StatelessWidget {
  final DocumentReference documentReference;
  final String product_type;

  const VerticalList({this.documentReference, this.product_type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(product_type),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('product')
              .where('product_type', isEqualTo: documentReference)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Loading...");
            return new ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  //return new Text(ds['product_name'].toString());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(ds['image'].toString(),)),
                      title: InkWell(
                        onTap: () => _content(
                            ds['product_name'].toString(), context, index),
                        child: Text(ds['product_name'].toString()),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  void _content(String productName, BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StreamBuilder(
            stream: Firestore.instance.collection('product').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("");
              return Product_Details(
                product_name: productName,
              );
            })));
  }
}