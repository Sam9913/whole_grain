import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarc/ProductDetails.dart';

class Calculate extends StatelessWidget {
	final List<String> productName;
	final List<double> productDetails;

	const Calculate({
		this.productName,
		this.productDetails,
	});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Calculator"),
			),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Column(
						children: <Widget>[
							Align(
									alignment: Alignment.centerLeft,
									child: Text(productName.length == 0 ? "No item added!" : "The product you have chosen:")),
							SizedBox(
								height: 8,
							),
							ListView.builder(
									shrinkWrap: true,
									itemCount: productName.length,
									itemBuilder: (context, index) {
										if(productName.length == 0){
											return Text("No item added!");
										}
										return Text(productName[index]);
									}),
							Align(
								alignment: Alignment.topLeft,
								child: Padding(
										padding: const EdgeInsets.all(8.0),
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
															DataCell(Text(productDetails.length == 0
																	? "-" :
															productDetails[15].toStringAsFixed(2) ==
																	"0.00"
																	? "-" : productDetails[15].toStringAsFixed(2))),
														]),
													],
												),
											],
										)),
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