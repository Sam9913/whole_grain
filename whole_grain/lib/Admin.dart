import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarc/AdminAll.dart';
import 'package:tarc/EditFood.dart';
import 'package:tarc/ProductDetails.dart';

class AdminAction extends StatefulWidget {
  @override
  _AdminActionState createState() => _AdminActionState();
}

class _AdminActionState extends State<AdminAction> {
  int showNum = 3;

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
                    return Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0 ,top: 16.0),
                            child: Text(ds_type["Name"], style: TextStyle(fontWeight: FontWeight
                                    .bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('product')
                                    .where("product_type", isEqualTo: dr)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Text("Loading...");
                                  return Column(
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemCount: showNum,
                                          itemBuilder: (context, index) {
                                            DocumentSnapshot ds = snapshot.data.documents[index];
                                            //return new Text(ds['product_name'].toString());
                                            return Column(
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
																						ds["product_name"].toString())));
																					},
																				),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                                  child: Divider(
                                                    thickness: 1.0,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      Offstage(
                                        offstage: snapshot.data.documents.length > 3 ? false :
                                        true,
                                        child: Center(
                                          child: Container(
                                            child: FlatButton(onPressed: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowAll()));
                                            },
                                              child: Text("Show All"),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
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
