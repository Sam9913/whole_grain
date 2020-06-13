import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProductDetails.dart';

class Meal extends StatefulWidget {
	final mealName;
	final date;

  const Meal({Key key, this.mealName, this.date}) : super(key: key);

  @override
  _MealState createState() => _MealState();
}

class _MealState extends State<Meal> {
	String token;
  List<double> productDetails = List<double>();

	@override
  void initState() {
		getData();
		/*for(int index = 0 ; index < widget.productDetails.length ; index++ ) {
			data.add(Diet(
				date: DateTime.now().toString().substring(0,10),
				time: DateTime.now().toString().substring(11),
				dietName: widget.productDetails[index].material_name,
				dietNumber: widget.productDetails[index].material_count,
			));
		}*/
		print(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.greenAccent,
				title: Text(widget.mealName, style: TextStyle(color: Colors.black),),
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body: Padding(
			  padding: const EdgeInsets.all(8.0),
			  child: SingleChildScrollView(
			    child: StreamBuilder(
			    	stream: Firestore.instance.collection(widget.mealName.toLowerCase()).where
			    		("token", isEqualTo: token).where("date", isEqualTo: widget.date)
			    			.snapshots(),
			    	builder: (context, snapshot){
			    		if(snapshot.hasData){
			    			if(snapshot.data.documents.length == 0){
			    				return Text("No whole grain food added!");
			    			}
			    			DocumentSnapshot ds = snapshot.data.documents[0];
			    			List<String> productName = List.from(ds['product']);
			    			productDetails = List.from(ds["product_details"]);

			    			return Column(
			    			  children: <Widget>[
											Align(
													alignment: Alignment.centerLeft,
													child: Text("Whole grain food you have taken: ")),
											SizedBox(
												height: 8,
											),
			    			    Column(
			    			    	children: <Widget>[
			    			    		buildName(productName),
			    			    		Padding(
			    			    				padding: EdgeInsets.only(top: 16.0),
			    			    				child: Text("Food Intake Information", style: TextStyle(fontWeight: FontWeight.bold),)),
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
			    			  ],
			    			);

			    			//DocumentSnapshot ds = snapshot.data.documents[0];
			    			//productDetails = List.from(snapshot.data.documents[0]["product_details"]);

			    		}
			    		else return Container(child: Center(child: CircularProgressIndicator(),),);
			    	},
			    ),
			  ),
			),
			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.close),
				backgroundColor: Colors.greenAccent,
				onPressed: (){
					Product_Details.productName = [];

					for(int i=0;i<16;i++){
						Product_Details.productDetails[i] = 0.0;
					}

					Navigator.of(context).pop(true);
				},
			),
		);
  }

  Widget buildName(List<String> productName){
		return ListView.builder(
				shrinkWrap: true,
				itemCount: productName.length,
				itemBuilder: (context, index){
					return Row(
						children: <Widget>[
							Container(
								height: 5.0,
								width: 5.0,
								decoration: new BoxDecoration(
									color: Colors.black,
									shape: BoxShape.circle,
								),
							),
							Flexible(
							  child: Padding(
							  	padding: const EdgeInsets.only
							  		(left: 8.0),
							  	child: Text(productName[index]),
							  ),
							),
						],
					);
				});
	}

	getData() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		token = prefs.getString("token");
	}
}

/**/