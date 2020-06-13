import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EditFood.dart';

class ShowAll extends StatefulWidget {
	final DocumentReference productType;

  const ShowAll({Key key, this.productType}) : super(key: key);

  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.greenAccent,
				title: Text(widget.productType.toString(), style: TextStyle(color: Colors.black)),
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body: SingleChildScrollView(
			  child: StreamBuilder(
			  		stream: Firestore.instance
			  				.collection('product')
			  				.where("product_type", isEqualTo: widget.productType)
			  				.snapshots(),
			  		builder: (context, snapshot) {
			  			if (!snapshot.hasData) return Text("Loading...");
			  			return Column(
			  				children: <Widget>[
			  					ListView.builder(
			  							shrinkWrap: true,
			  							physics: const ClampingScrollPhysics(),
			  							itemCount: snapshot.data.documents.length,
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
			  													ds["product_name"])));
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
			  				],
			  			);
			  		}),
			),
		);
  }
}
