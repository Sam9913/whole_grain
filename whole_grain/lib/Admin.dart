import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarc/EditFood.dart';
import 'package:tarc/ProductDetails.dart';

class AdminAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Admin Page", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('product_type').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds_type = snapshot.data.documents[index];
                    DocumentReference dr =
                        Firestore.instance.collection('product_type').document(ds_type.documentID);
                    return StreamBuilder(
                        stream: Firestore.instance
                            .collection('product')
                            .where("product_type", isEqualTo: dr)
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
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                          ds['image'].toString(),
                                        )),
                                        title: Text(ds['product_name']),
																				trailing: GestureDetector(
																					child: Icon(Icons.navigate_next, color: Colors.black87,),
																					onTap: (){
																						Navigator.push(context, MaterialPageRoute(builder:
																						(context) => EditFood(productName:
																						ds["product_name"])));
																					},
																				),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        });
                  });
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
