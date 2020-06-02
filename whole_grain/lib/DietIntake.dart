import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarc/ProductDetails.dart';
import 'Diet.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Meal.dart';

class DietIntake extends StatefulWidget {
	final List<String> productName;
	final List<DietCalculate> productDetails;

	const DietIntake({
		this.productName,
		this.productDetails,
	});

	@override
	_DietIntakeState createState() => _DietIntakeState();
}

class _DietIntakeState extends State<DietIntake> with TickerProviderStateMixin {
	final List<Tab> myTabs = <Tab>[Tab(text: 'Day 1'), Tab(text: 'Day 2'), Tab(text: 'Day 3')];
	TabController _tabController;
	List<Diet> data = List<Diet>();

	@override
	void initState() {
		super.initState();
		for(int index = 0 ; index < widget.productDetails.length ; index++ ) {
			data.add(Diet(
				date: DateTime.now().toString().substring(0,10),
				time: DateTime.now().toString().substring(11),
				dietName: widget.productDetails[index].material_name,
				dietNumber: widget.productDetails[index].material_count,
			));
		}
		_tabController = TabController(vsync: this, length: myTabs.length);
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Diet Intake"),
			),
			body: SingleChildScrollView(
			  child: Column(
			    children: <Widget>[
			  		TabBar(
			  			controller: _tabController,
			  			tabs: myTabs,
			  			labelColor: Colors.black,
			  			indicatorColor: Colors.greenAccent,
			  			indicatorWeight: 5.0,
			  		),
			      Container(
			  			height: 270,
			        child: TabBarView(
			        	controller: _tabController,
			        	children: myTabs.map((Tab tab) {
			        		if (tab.text == 'Day 1') {
			        			return Column(
			        				children: <Widget>[
			        					Padding(
			        					  padding: const EdgeInsets.all(8.0),
			        					  child: Container(
			        					    child: ListTile(
			        					    	title: Text("Breakfast"),
			        								subtitle: Row(
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
			        								      child: Text("Food name 1"),
			        								    ),
			        								  ],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																(context) => Meal(mealName: "Breakfast",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        					    ),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        					  ),
			        					),
			        					Padding(
			        					  padding: const EdgeInsets.all(8.0),
			        					  child: Container(
			        					    child: ListTile(
			        					    	title: Text("Lunch"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Lunch",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        					    ),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        					  ),
			        					),
			        					Padding(
			        					  padding: const EdgeInsets.all(8.0),
			        					  child: Container(
			        					    child: ListTile(
			        					    	title: Text("Dinner"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Dinner",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        					    ),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        					  ),
			        					),
			        				],
			        			);
			        		}
			        		else if (tab.text == 'Day 2'){
			        			return Column(
			        				children: <Widget>[
			        					Padding(
			        						padding: const EdgeInsets.all(8.0),
			        						child: Container(
			        							child: ListTile(
			        								title: Text("Breakfast"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Breakfast",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        							),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        						),
			        					),
			        					Padding(
			        						padding: const EdgeInsets.all(8.0),
			        						child: Container(
			        							child: ListTile(
			        								title: Text("Lunch"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Lunch",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        							),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        						),
			        					),
			        					Padding(
			        						padding: const EdgeInsets.all(8.0),
			        						child: Container(
			        							child: ListTile(
			        								title: Text("Dinner"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Dinner",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        							),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        						),
			        					),
			        				],
			        			);
			        		}
			        		else{
			        			return Column(
			        				children: <Widget>[
			        					Padding(
			        						padding: const EdgeInsets.all(8.0),
			        						child: Container(
			        							child: ListTile(
			        								title: Text("Breakfast"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Breakfast",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        							),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        						),
			        					),
			        					Padding(
			        						padding: const EdgeInsets.all(8.0),
			        						child: Container(
			        							child: ListTile(
			        								title: Text("Lunch"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Lunch",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        							),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        						),
			        					),
			        					Padding(
			        						padding: const EdgeInsets.all(8.0),
			        						child: Container(
			        							child: ListTile(
			        								title: Text("Dinner"),
			        								subtitle: Row(
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
			        											child: Text("Food name 1"),
			        										),
			        									],
			        								),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Dinner",productDetails: widget
																		.productDetails, productName: widget.productName,))),
															),
			        							),
			        							decoration: BoxDecoration(
			        								borderRadius: new BorderRadius.circular(10.0),
			        								color: Colors.grey.withOpacity(0.5),
			        							),
			        						),
			        					),
			        				],
			        			);
			        		}
			        	}).toList(),
			        ),
			      ),
						buildChart(data),
			    ],
			  ),
			),
		);
	}

	Widget buildChart(List<Diet> data) {
		List<charts.Series<Diet, String>> series = [
			charts.Series(
				id: "Diet Intake",
				data: data,
				seriesCategory: data[0].dietName,
				domainFn: (Diet series, _) => series.date,
				measureFn: (Diet series, _) => series.dietNumber,
			)
		];

		return Container(
			height: 400,
			padding: EdgeInsets.all(20),
			child: Card(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Column(
						children: <Widget>[
							Text(
								"Diet Intake",
								style: Theme.of(context).textTheme.bodyText1,
							),
							Expanded(
									child: charts.BarChart(
										series,
										animate: true,
										barGroupingType: charts.BarGroupingType.groupedStacked,
									))
						],
					),
				),
			),
		);
	}

}