import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowAverage extends StatefulWidget {
  @override
  _ShowAverageState createState() => _ShowAverageState();
}

class _ShowAverageState extends State<ShowAverage> {
	bool offstage;

	List<double> productDetails;

	String token;

	getToken() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		token = prefs.getString("token");
	}

	@override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Text("Average of diet intake", style: TextStyle(color: Colors.black)),
				backgroundColor: Colors.greenAccent,
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body: StreamBuilder(
				stream: Firestore.instance.collection("average").where("token", isEqualTo: token).snapshots(),
				builder: (context, snapshot){
					if(snapshot.hasData){
						if(snapshot.data.documents.length == 0){
							return Container(
							  child: Column(
									crossAxisAlignment: CrossAxisAlignment.center,
							    mainAxisAlignment: MainAxisAlignment.center,
							    children: <Widget>[
							      Text("No whole grain food added!", textAlign: TextAlign.center,),
							  		Padding(
							  		  padding: const EdgeInsets.only(top: 8.0),
							  		  child: Center(
							  		    child: Container(
											decoration: BoxDecoration(
												color: Colors.greenAccent,
												borderRadius: BorderRadius.circular(10.0),
											),
											child: FlatButton(child: Text("Go to Home"), onPressed: (){
												Navigator.popUntil(context, (route) => route.isFirst);
											},),),
							  		  ),
							  		),
							    ],
							  ),
							);
						}

						productDetails = List.from(snapshot.data.documents[0]["average"]);
						return Container(
							child:  SingleChildScrollView(
								child: Padding(
								  padding: const EdgeInsets.only(top: 8.0),
								  child: Column(
								  	children: <Widget>[

								  		DataTable(
								  			columns: [
								  				DataColumn(label: Text('Label')),
								  				DataColumn(label: Text('Amount')),
								  			],
								  			rows: [
								  				DataRow(cells: [
								  					DataCell(Text('Serving size (g)')),
								  					DataCell(Text(productDetails[0].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[0].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text(
								  							'Total whole grain content per serving (g)')),
								  					DataCell(Text(productDetails[1].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[1].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Total whole grain content (%)')),
								  					DataCell(Text(productDetails[2].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[2].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Calorie per serving (kcal)')),
								  					DataCell(Text( productDetails[3].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[3].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Total fat (g)')),
								  					DataCell(Text(
								  							productDetails[4].toStringAsFixed(2) ==
								  									"0.00"
								  									? "-"
								  									: productDetails[4].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Saturated fat (g)')),
								  					DataCell(Text(productDetails[5].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							:  productDetails[5].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Monounsaturated fat (g)')),
								  					DataCell(Text(productDetails[6].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							:  productDetails[6].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('polyunsaturated fat (g)')),
								  					DataCell(Text(productDetails[7].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[7].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Carbohydrate (g)')),
								  					DataCell(Text(productDetails[8].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							:  productDetails[8].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Fibre (g)')),
								  					DataCell(Text(productDetails[9].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[9].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Total sugar (g)')),
								  					DataCell(Text(productDetails[10].toStringAsFixed(2) ==
								  							"0.00"
								  							? "-"
								  							: productDetails[10].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Protein (g)')),
								  					DataCell(Text(
								  							productDetails[11].toStringAsFixed(2) ==
								  									"0.00"
								  									? "-"
								  									: productDetails[11].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Sodium (mg)')),
								  					DataCell(Text(
								  							productDetails[12].toStringAsFixed(2) ==
								  									"0.00"
								  									? "-" : productDetails[12].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Potassium (mg)')),
								  					DataCell(Text(
								  							productDetails[13].toStringAsFixed(2) ==
								  									"0.00"
								  									? "-" : productDetails[13].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Calcium (mg)')),
								  					DataCell(Text(
								  							productDetails[14].toStringAsFixed(2) ==
								  									"0.00"
								  									? "-" : productDetails[14].toStringAsFixed(2))),
								  				]),
								  				DataRow(cells: [
								  					DataCell(Text('Iron (mg)')),
								  					DataCell(Text(
								  							productDetails[15].toStringAsFixed(2) ==
								  									"0.00"
								  									? "-" : productDetails[15].toStringAsFixed(2))),
								  				]),
								  			],
								  		),
								  	],
								  ),
								),
							),
						);
					}

					return Center(child: CircularProgressIndicator(),);
				},
			)
		);
  }
}
