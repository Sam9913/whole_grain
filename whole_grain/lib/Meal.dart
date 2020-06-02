import 'package:flutter/material.dart';
import 'Diet.dart';
import 'ProductDetails.dart';

class Meal extends StatefulWidget {
	final mealName;
	final List<String> productName;
	final List<DietCalculate> productDetails;

  const Meal({Key key, this.productName, this.productDetails, this.mealName}) : super(key: key);

  @override
  _MealState createState() => _MealState();
}

class _MealState extends State<Meal> {
	List<Diet> data = List<Diet>();

	@override
  void initState() {
		for(int index = 0 ; index < widget.productDetails.length ; index++ ) {
			data.add(Diet(
				date: DateTime.now().toString().substring(0,10),
				time: DateTime.now().toString().substring(11),
				dietName: widget.productDetails[index].material_name,
				dietNumber: widget.productDetails[index].material_count,
			));
		}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Text(widget.mealName),
			),
			body: Padding(
			  padding: const EdgeInsets.all(8.0),
			  child: SingleChildScrollView(
			    child: Column(
			    	children: <Widget>[
			    		Align(
			    			alignment: Alignment.centerLeft,
			    			child: Text(widget.productName.length == 0 ? "No whole grain food added!" : "Whole grain food you have taken: ")),
			    		SizedBox(
			    			height: 8,
			    		),
			    		ListView.builder(
			    				shrinkWrap: true,
			    				itemCount: widget.productName.length,
			    				itemBuilder: (context, index) {
			    					return Padding(
			    					  padding: const EdgeInsets.only(top: 8.0),
			    					  child: Row(
			    					    children: <Widget>[
												Container(
													height: 5.0,
													width: 5.0,
													decoration: new BoxDecoration(
														color: Colors.black,
														shape: BoxShape.circle,
													),
												),
			    					      Padding(
			    					        padding: const EdgeInsets.only(left: 8.0),
			    					        child: Text(widget.productName[index]),
			    					      ),
			    					    ],
			    					  ),
			    					);
			    				}),
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
									DataCell(Text(widget.productDetails[0].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[0].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text(
											'Total whole grain content per serving (g)')),
									DataCell(Text(widget.productDetails[1].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[1].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Total whole grain content (%)')),
									DataCell(Text(widget.productDetails[2].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[2].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Calorie per serving (kcal)')),
									DataCell(Text( widget.productDetails[3].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[3].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Total fat (g)')),
									DataCell(Text(
											widget.productDetails[4].material_count.toStringAsFixed(2) ==
													"0.00"
													? "-"
													: widget.productDetails[4].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Saturated fat (g)')),
									DataCell(Text(widget.productDetails[5].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											:  widget.productDetails[5].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Monounsaturated fat (g)')),
									DataCell(Text(widget.productDetails[6].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											:  widget.productDetails[6].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('polyunsaturated fat (g)')),
									DataCell(Text(widget.productDetails[7].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[7].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Carbohydrate (g)')),
									DataCell(Text(widget.productDetails[8].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											:  widget.productDetails[8].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Fibre (g)')),
									DataCell(Text(widget.productDetails[9].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[9].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Total sugar (g)')),
									DataCell(Text(widget.productDetails[10].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-"
											: widget.productDetails[10].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Protein (g)')),
									DataCell(Text(
											widget.productDetails[11].material_count.toStringAsFixed(2) ==
													"0.00"
													? "-"
													: widget.productDetails[11].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Sodium (mg)')),
									DataCell(Text(
											widget.productDetails[12].material_count.toStringAsFixed(2) ==
													"0.00"
													? "-" : widget.productDetails[12].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Potassium (mg)')),
									DataCell(Text(
											widget.productDetails[13].material_count.toStringAsFixed(2) ==
													"0.00"
													? "-" : widget.productDetails[13].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Calcium (mg)')),
									DataCell(Text(
											widget.productDetails[14].material_count.toStringAsFixed(2) ==
													"0.00"
													? "-" : widget.productDetails[14].material_count.toStringAsFixed(2))),
								]),
								DataRow(cells: [
									DataCell(Text('Iron (mg)')),
									DataCell(Text(
									widget.productDetails[15].material_count.toStringAsFixed(2) ==
											"0.00"
											? "-" : widget.productDetails[15].material_count.toStringAsFixed(2))),
								]),
							],
						),
			    	],
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


}
