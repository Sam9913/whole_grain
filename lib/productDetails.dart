import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wholegrain/dietIntake.dart';
import 'calculate.dart';

class Product_Details extends StatefulWidget {
  Product_Details({Key key, this.product_name}) : super(key: key);
  final String product_name;
  static List<String> productName = [];
  static List<double> productDetails = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,];
  @override
  _Product_DetailsState createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {

  double value = 1.0;
  String dropDownValue = '1';
   double serving_size;
   double totalWG_content_per_serving;
   double totalWG_content;
   double kcal_per_serving;
   double total_fat;
   double saturated_fat;
   double monounsaturated_fat;
   double polyunsaturated_fat;
   double carbohydrate_double;
   double fibre_double;
   double total_sugar;
   double protein_double;
   double sodium_double;
   double potassium_double;
   double calcium_double;
   double iron_double;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product_name),
      ),
      body: Container(
        height: 1000,
        child: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: Firestore.instance
                            .collection('product')
                            .where('product_name', isEqualTo: widget.product_name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Text("");
                          return new ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds =
                                snapshot.data.documents[index];

                                serving_size = double.parse(ds['serving_size'].toString());
                                totalWG_content = double.parse(ds['totalWG_content_per_serving'].toString());
                                totalWG_content_per_serving = double.parse(ds['totalWG_content'].toString());
                                kcal_per_serving = double.parse(ds['kcal_per_serving'].toString());
                                total_fat = double.parse(ds['total_fat'].toString());
                                saturated_fat = ds['saturated_fat'].toString() == "-1" ? 0 : ds['saturated_fat'].toString() == "-2" ? 0 : double.parse(ds['saturated_fat'].toString());
                                monounsaturated_fat = ds['monounsaturated_fat'].toString() == "-1" ? 0.0 : ds['monounsaturated_fat'].toString() == "-2" ? 0 :  double.parse(ds['monounsaturated_fat'].toString());
                                polyunsaturated_fat = ds['polyunsaturated_fat'].toString() == "-1" ? 0.0 : ds['polyunsaturated_fat'].toString() == "-2" ? 0 :  double.parse(ds['polyunsaturated_fat'].toString()) ;
                                carbohydrate_double = ds['carbohydrate'].toString() == "-1" ? 0 : ds['carbohydrate'].toString() == "-2" ? 0 :  double.parse(ds['carbohydrate'].toString());
                                fibre_double = ds['fibre'].toString() == "-1" ? 0 : ds['fibre'].toString() == "-2" ? 0 :  double.parse(ds['fibre'].toString());
                                total_sugar = ds['total_sugar'].toString() == "-1" ? 0 : ds['total_sugar'].toString() == "-2" ? 0 :  double.parse(ds['total_sugar'].toString());
                                protein_double = ds['protein'].toString() == "-1" ? 0 : ds['protein'].toString() == "-2" ? 0 :  double.parse(ds['protein'].toString());
                                sodium_double = ds['sodium'].toString() == "-1" ? 0 : ds['sodium'].toString() == "-2" ? 0 :  double.parse(ds['sodium'].toString());
                                potassium_double = ds['potassium'].toString() == "-1" ? 0 : ds['potassium'].toString() == "-2" ? 0 :  double.parse(ds['potassium'].toString());
                                calcium_double = ds['calcium'].toString() == "-1" ? 0 : ds['calcium'].toString() == "-2" ? 0 :  double.parse(ds['calcium'].toString());
                                iron_double = ds['iron'].toString() == "-1" ? 0 : ds['iron'].toString() == "-2" ? 0 :  double.parse(ds['iron'].toString());

                                serving_size *= value;
                                totalWG_content *= value;
                                totalWG_content_per_serving *= value;
                                kcal_per_serving *= value;
                                total_fat *= value;
                                saturated_fat *= value;
                                monounsaturated_fat *= value;
                                polyunsaturated_fat *= value;
                                carbohydrate_double *= value;
                                fibre_double *= value;
                                total_sugar *= value;
                                protein_double *= value;
                                sodium_double *= value;
                                potassium_double *= value;
                                calcium_double *= value;
                                iron_double *= value;

                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(
                                            ds['image'].toString(),
                                            width: 100,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Column(
                                              children: <Widget>[
                                                Text("Portion"),
                                                DropdownButton<String>(
                                          value: dropDownValue,
                                          icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.teal,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropDownValue = newValue;
                                      value = double.parse(newValue);
                                    });
                                  },
                                  items: <String>['0.5','1','2']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                              ],
                                            ),
                                          ),
                                          DataTable(
                                            columns: [
                                              DataColumn(label: Text('Label')),
                                              DataColumn(label: Text('Amount')),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(
                                                    Text('Serving size (g)')),
                                                DataCell(Text(serving_size.toStringAsFixed(2) == "0.00" ? "-" : serving_size.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    'Total whole grain content per serving (g)')),
                                                DataCell(Text(totalWG_content_per_serving.toStringAsFixed(2) == "0.00" ? "-" : totalWG_content_per_serving.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    'Total whole grain content (%)')),
                                                DataCell(Text(totalWG_content.toStringAsFixed(2) == "0.00" ? "-" : totalWG_content.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    'Calorie per serving (kcal)')),
                                                DataCell(Text(kcal_per_serving.toStringAsFixed(2) == "0.00" ? "-" : kcal_per_serving.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Total fat (g)')),
                                                DataCell(Text(total_fat.toStringAsFixed(2) == "0.00" ? "-" : total_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(
                                                    Text('Saturated fat (g)')),
                                                DataCell(Text(saturated_fat.toStringAsFixed(2) == "0.00" ? "-" : saturated_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    'Monounsaturated fat (g)')),
                                                DataCell(Text(monounsaturated_fat.toStringAsFixed(2) == "0.00" ? "-" : monounsaturated_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    'polyunsaturated fat (g)')),
                                                DataCell(Text(polyunsaturated_fat.toStringAsFixed(2) == "0.00" ? "-" : polyunsaturated_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(
                                                    Text('Carbohydrate (g)')),
                                                DataCell(Text(carbohydrate_double.toStringAsFixed(2) == "0.00" ? "-" : carbohydrate_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Fibre (g)')),
                                                DataCell(Text(fibre_double.toStringAsFixed(2) == "0.00" ? "-" : fibre_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(
                                                    Text('Total sugar (g)')),
                                                DataCell(Text(total_sugar.toStringAsFixed(2) == "0.00" ? "-" : total_sugar.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Protein (g)')),
                                                DataCell(Text(protein_double.toStringAsFixed(2) == "0.00" ? "-" : protein_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Sodium (mg)')),
                                                DataCell(Text(sodium_double.toStringAsFixed(2) == "0.00" ? "-" : sodium_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(
                                                    Text('Potassium (mg)')),
                                                DataCell(Text(potassium_double.toStringAsFixed(2) == "0.00" ? "-" : potassium_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Calcium (mg)')),
                                                DataCell(Text(calcium_double.toStringAsFixed(2) == "0.00" ? "-" : calcium_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Iron (mg)')),
                                                DataCell(Text(iron_double.toStringAsFixed(2) == "0.00" ? "-" : iron_double.toStringAsFixed(2))),
                                              ]),
                                            ],
                                          ),
                                        ],
                                      )),
                                );
                              });
                        }),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Colors.greenAccent,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.greenAccent,
              onTap: () {
                for (int index = 0; index < Product_Details.productName.length; index++) {
                  if (Product_Details.productName[index] == widget.product_name) {
                    Fluttertoast.showToast(
                      msg: "Already added in",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    Product_Details.productName.removeAt(index);
                  }
                }
                Product_Details.productName.add(widget.product_name);

                Product_Details.productDetails[0] += serving_size;
                Product_Details.productDetails[1] += totalWG_content_per_serving;
                Product_Details.productDetails[2] += totalWG_content;
                Product_Details.productDetails[3] += kcal_per_serving;
                Product_Details.productDetails[4] += total_fat;
                Product_Details.productDetails[5] += saturated_fat;
                Product_Details.productDetails[6] += monounsaturated_fat;
                Product_Details.productDetails[7] += polyunsaturated_fat;
                Product_Details.productDetails[8] += carbohydrate_double;
                Product_Details.productDetails[9] += fibre_double;
                Product_Details.productDetails[10] += total_sugar;
                Product_Details.productDetails[11] += protein_double;
                Product_Details.productDetails[12] += sodium_double;
                Product_Details.productDetails[13] += potassium_double;
                Product_Details.productDetails[14] += calcium_double;
                Product_Details.productDetails[15] += iron_double;
              },
              label: 'Add',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Colors.greenAccent),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.done),
              backgroundColor: Colors.greenAccent,
              onTap: () => _calculate(context, Product_Details.productName, Product_Details.productDetails),
              label: 'Done',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Colors.greenAccent)
        ],
      ),
      /*getFab(
        product_name: widget.product_name,
        serving_size: serving_size,
        totalWG_content: totalWG_content,
        totalWG_content_per_serving: totalWG_content_per_serving,
        kcal_per_serving: kcal_per_serving,
        total_fat: total_fat,
        saturated_fat: saturated_fat,
        monounsaturated_fat: monounsaturated_fat,
        polyunsaturated_fat: polyunsaturated_fat,
        carbohydrate_double: carbohydrate_double,
        fibre_double: fibre_double,
        total_sugar: total_sugar,
        protein_double: protein_double,
        sodium_double: sodium_double,
        potassium_double: potassium_double,
        calcium_double: calcium_double,
        iron_double: iron_double,
      ),*/
    );
  }

  void _calculate(BuildContext context, List<String> productName, List<double> productDetails) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DietIntake(
          productName: productName,
          productDetails: productDetails,
        )));
  }
}

/*class getFab extends StatelessWidget {
  final String product_name;
  final double serving_size;
  final double totalWG_content_per_serving;
  final double totalWG_content;
  final double kcal_per_serving;
  final double total_fat;
  final double saturated_fat;
  final double monounsaturated_fat;
  final double polyunsaturated_fat;
  final double carbohydrate_double;
  final double fibre_double;
  final double total_sugar;
  final double protein_double;
  final double sodium_double;
  final double potassium_double;
  final double calcium_double;
  final double iron_double;
  static List<String> productName = [];
  static List<double> productDetails = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,];


  const getFab({
    this.product_name,
    this.serving_size,
    this.totalWG_content,
    this.totalWG_content_per_serving,
    this.kcal_per_serving,
    this.total_fat,
    this.saturated_fat,
    this.monounsaturated_fat,
    this.polyunsaturated_fat,
    this.carbohydrate_double,
    this.fibre_double,
    this.total_sugar,
    this.protein_double,
    this.sodium_double,
    this.potassium_double,
    this.calcium_double,
    this.iron_double,
  });

  @override
  Widget build(BuildContext context) {
    return
  }

  void _calculate(BuildContext context, List<String> productName, List<double> productDetails) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Calculate(
          productName: productName,
          productDetails: productDetails,
        )));
  }
}*/
