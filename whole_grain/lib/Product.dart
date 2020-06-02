import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarc/ProductDetails.dart';

//import 'calculate.dart';

class Product extends StatelessWidget {
  final int index;
  final String product_name;
  final String image_url;

  //const Product({this.productImage, this.productName, this.productType});
  const Product({
    this.index,
    this.product_name,
    this.image_url,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 250,
        width: 270,
        //color: Colors.blue,
        margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Card(
          child: InkWell(
            onTap: () => _content(product_name, context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                Image.network(
                  image_url,
                  width: 100,
                ),
                SizedBox(height: 7),
                Text(
                  product_name,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
        ));
  }

  void _content(String productName, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Product_Details(
              product_name: productName,
            )));
  }
}