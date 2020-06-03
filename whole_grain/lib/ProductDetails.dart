import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarc/Diet.dart';
import 'package:tarc/DietIntake.dart';

//import 'package:wholegrain/dietIntake.dart';
//import 'calculate.dart';

class Product_Details extends StatefulWidget {
  Product_Details({Key key, this.product_name}) : super(key: key);
  final String product_name;
  static List<String> productName = [];
  static List<double> productDetails = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];
  static List<DietCalculate> dietIntake = [];

  @override
  _Product_DetailsState createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  List<Color> onClick = <Color>[Colors.white, Colors.white, Colors.white];
  String onClickTitle;
  List<String> detailsName = <String>[
    "Serving size",
    "Total whole grain content per serving",
    "Total whole grain content",
    "Calories(kcal) per serving",
    "Total fat",
    "Saturated fat",
    "Monounsaturated fat",
    "Polyunsaturated fat",
    "Carbohydrate",
    "Fibre",
    "Total sugar",
    "Protein",
    "Sodium",
    "Potassium",
    "Calcium",
    "Iron"
  ];
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
                                DocumentSnapshot ds = snapshot.data.documents[index];

                                serving_size = double.parse(ds['serving_size'].toString());
                                totalWG_content =
                                    double.parse(ds['totalWG_content_per_serving'].toString());
                                totalWG_content_per_serving =
                                    double.parse(ds['totalWG_content'].toString());
                                kcal_per_serving = double.parse(ds['kcal_per_serving'].toString());
                                total_fat = double.parse(ds['total_fat'].toString());
                                saturated_fat = ds['saturated_fat'].toString() == "-1"
                                    ? 0
                                    : ds['saturated_fat'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['saturated_fat'].toString());
                                monounsaturated_fat = ds['monounsaturated_fat'].toString() == "-1"
                                    ? 0.0
                                    : ds['monounsaturated_fat'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['monounsaturated_fat'].toString());
                                polyunsaturated_fat = ds['polyunsaturated_fat'].toString() == "-1"
                                    ? 0.0
                                    : ds['polyunsaturated_fat'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['polyunsaturated_fat'].toString());
                                carbohydrate_double = ds['carbohydrate'].toString() == "-1"
                                    ? 0
                                    : ds['carbohydrate'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['carbohydrate'].toString());
                                fibre_double = ds['fibre'].toString() == "-1"
                                    ? 0
                                    : ds['fibre'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['fibre'].toString());
                                total_sugar = ds['total_sugar'].toString() == "-1"
                                    ? 0
                                    : ds['total_sugar'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['total_sugar'].toString());
                                protein_double = ds['protein'].toString() == "-1"
                                    ? 0
                                    : ds['protein'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['protein'].toString());
                                sodium_double = ds['sodium'].toString() == "-1"
                                    ? 0
                                    : ds['sodium'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['sodium'].toString());
                                potassium_double = ds['potassium'].toString() == "-1"
                                    ? 0
                                    : ds['potassium'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['potassium'].toString());
                                calcium_double = ds['calcium'].toString() == "-1"
                                    ? 0
                                    : ds['calcium'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['calcium'].toString());
                                iron_double = ds['iron'].toString() == "-1"
                                    ? 0
                                    : ds['iron'].toString() == "-2"
                                        ? 0
                                        : double.parse(ds['iron'].toString());

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
                                                  items: <String>[
                                                    '0.5',
                                                    '1',
                                                    '2'
                                                  ].map<DropdownMenuItem<String>>((String value) {
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
                                                DataCell(Text('Serving size (g)')),
                                                DataCell(Text(
                                                    serving_size.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : serving_size.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    'Total whole grain content per serving (g)')),
                                                DataCell(Text(totalWG_content_per_serving
                                                            .toStringAsFixed(2) ==
                                                        "0.00"
                                                    ? "-"
                                                    : totalWG_content_per_serving
                                                        .toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Total whole grain content (%)')),
                                                DataCell(Text(
                                                    totalWG_content.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : totalWG_content.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Calorie per serving (kcal)')),
                                                DataCell(Text(
                                                    kcal_per_serving.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : kcal_per_serving.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Total fat (g)')),
                                                DataCell(Text(total_fat.toStringAsFixed(2) == "0.00"
                                                    ? "-"
                                                    : total_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Saturated fat (g)')),
                                                DataCell(Text(
                                                    saturated_fat.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : saturated_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Monounsaturated fat (g)')),
                                                DataCell(Text(
                                                    monounsaturated_fat.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : monounsaturated_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('polyunsaturated fat (g)')),
                                                DataCell(Text(
                                                    polyunsaturated_fat.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : polyunsaturated_fat.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Carbohydrate (g)')),
                                                DataCell(Text(
                                                    carbohydrate_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : carbohydrate_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Fibre (g)')),
                                                DataCell(Text(
                                                    fibre_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : fibre_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Total sugar (g)')),
                                                DataCell(Text(
                                                    total_sugar.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : total_sugar.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Protein (g)')),
                                                DataCell(Text(
                                                    protein_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : protein_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Sodium (mg)')),
                                                DataCell(Text(
                                                    sodium_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : sodium_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Potassium (mg)')),
                                                DataCell(Text(
                                                    potassium_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : potassium_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Calcium (mg)')),
                                                DataCell(Text(
                                                    calcium_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : calcium_double.toStringAsFixed(2))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Iron (mg)')),
                                                DataCell(Text(
                                                    iron_double.toStringAsFixed(2) == "0.00"
                                                        ? "-"
                                                        : iron_double.toStringAsFixed(2))),
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      var size = MediaQuery.of(context).size;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Container(
                                height: 240,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                child: Icon(Icons.clear),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 9,
                                              child: Text("Choose meal intake",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      width: double.infinity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          InkWell(
                                            child: Container(
                                                height: 120,
                                                width: size.width / 4,
                                                child: Card(
                                                  color: onClick[0],
                                                  elevation: 4.0,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage("data_repo/7am.png"),
                                                          backgroundColor: Colors.white,
                                                          radius: 30,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: Text("Breakfast"),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            onTap: () {
                                              setState(() {
                                                for (int i = 0; i < 3; i++) {
                                                  onClick[i] = Colors.white;
                                                }
                                                onClick[0] = Colors.lightBlueAccent;
                                                onClickTitle = "breakfast";
                                              });
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                                height: 120,
                                                width: size.width / 4,
                                                child: Card(
                                                  color: onClick[1],
                                                  elevation: 4.0,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage("data_repo/12pm.png"),
                                                          backgroundColor: Colors.white,
                                                          radius: 30,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: Text("Lunch"),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            onTap: () {
                                              setState(() {
                                                for (int i = 0; i < 3; i++) {
                                                  onClick[i] = Colors.white;
                                                }
                                                onClick[1] = Colors.lightBlueAccent;
                                                onClickTitle = "lunch";
                                              });
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                                height: 120,
                                                width: size.width / 4,
                                                child: Card(
                                                  color: onClick[2],
                                                  elevation: 4.0,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage("data_repo/6pm.png"),
                                                          backgroundColor: Colors.white,
                                                          radius: 30,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: Text("Dinner"),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            onTap: () {
                                              setState(() {
                                                for (int i = 0; i < 3; i++) {
                                                  onClick[i] = Colors.white;
                                                }
                                                onClick[2] = Colors.lightBlueAccent;
                                                onClickTitle = "dinner";
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: FlatButton(
                                          color: Colors.greenAccent,
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences.getInstance();

                                            if(prefs.getStringList(onClickTitle) != null)
                                              Product_Details.productName = prefs.getStringList(onClickTitle);
                                            else
                                              Product_Details.productName = List<String>();

                                                QuerySnapshot existMeal = await Firestore.instance
                                                .collection(onClickTitle)
                                                .where("token", isEqualTo: prefs.getString("token"))
                                                .where("date", isEqualTo:
                                                        DateTime.now().toString().substring(0, 10)).getDocuments();

                                            Product_Details.productDetails[0] += serving_size;
                                            Product_Details.productDetails[1] +=
                                                totalWG_content_per_serving;
                                            Product_Details.productDetails[2] += totalWG_content;
                                            Product_Details.productDetails[3] += kcal_per_serving;
                                            Product_Details.productDetails[4] += total_fat;
                                            Product_Details.productDetails[5] += saturated_fat;
                                            Product_Details.productDetails[6] +=
                                                monounsaturated_fat;
                                            Product_Details.productDetails[7] +=
                                                polyunsaturated_fat;
                                            Product_Details.productDetails[8] +=
                                                carbohydrate_double;
                                            Product_Details.productDetails[9] += fibre_double;
                                            Product_Details.productDetails[10] += total_sugar;
                                            Product_Details.productDetails[11] += protein_double;
                                            Product_Details.productDetails[12] += sodium_double;
                                            Product_Details.productDetails[13] += potassium_double;
                                            Product_Details.productDetails[14] += calcium_double;
                                            Product_Details.productDetails[15] += iron_double;

                                            if (!Product_Details.productName.contains(widget.product_name)) {
                                              Product_Details.productName.add(widget.product_name);
                                              prefs.setStringList(onClickTitle, Product_Details
                                                  .productName);

                                              if (existMeal.documents.isEmpty) {
                                                Firestore.instance.collection(onClickTitle).add({
                                                  "token": prefs.getString("token"),
                                                  "date":
                                                      DateTime.now().toString().substring(0, 10),
                                                  "product": Product_Details.productName.toList(),
                                                  "product_details":
                                                      Product_Details.productDetails.toList(),
                                                });

                                                Navigator.pop(context);
                                              } else {
                                                Firestore.instance
                                                    .collection(onClickTitle)
                                                    .document(existMeal.documents[0].documentID)
                                                    .updateData({
                                                  "product": Product_Details.productName.toList(),
                                                  "product_details":
                                                      Product_Details.productDetails.toList(),
                                                });

                                                Navigator.pop(context);
                                              }

                                              /*for (int i = 0;
                                                  i < Product_Details.productDetails.length;
                                                  i++) {
                                                Product_Details.dietIntake.add(DietCalculate(
                                                    detailsName[i],
                                                    Product_Details.productDetails[i]));
                                              }*/
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "Already added in",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          },
                                          child: Text("Add"),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    });

                /*for (int index = 0; index < Product_Details.productName.length; index++) {
                  if (Product_Details.productName[index] == widget.product_name) {

                    Product_Details.productName.removeAt(index);
                  }
                }
                Product_Details.productName.add(widget.product_name); */
              },
              label: 'Add',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
              labelBackgroundColor: Colors.greenAccent),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.done),
              backgroundColor: Colors.greenAccent,
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DietIntake())),
              label: 'Done',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
              labelBackgroundColor: Colors.greenAccent)
        ],
      ),
    );
  }

  List<String> toList(List<String> product) {
    List<String> newtuete = List<String>();

    product.forEach((item) {
      newtuete.add(item.toString());
    });

    return newtuete.toList();
  }
}
