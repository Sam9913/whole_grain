import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarc/ProductDetails.dart';
import 'Diet.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Meal.dart';

class DietIntake extends StatefulWidget {
	@override
	_DietIntakeState createState() => _DietIntakeState();
}

class _DietIntakeState extends State<DietIntake> with TickerProviderStateMixin {
	final List<Tab> myTabs = <Tab>[Tab(text: 'Day 1'), Tab(text: 'Day 2'), Tab(text: 'Day 3')];
	TabController _tabController;
	List<Diet> data = List<Diet>();
	String token;

	@override
	void initState() {
		super.initState();
		getData();
		/*for(int index = 0 ; index < widget.productDetails.length ; index++ ) {
			data.add(Diet(
				date: DateTime.now().toString().substring(0,10),
				time: DateTime.now().toString().substring(11),
				dietName: widget.productDetails[index].material_name,
				dietNumber: widget.productDetails[index].material_count,
			));
		}*/
		_tabController = TabController(vsync: this, length: myTabs.length);
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		var size = MediaQuery.of(context).size;

		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.greenAccent,
				title: Text("Diet Intake", style: TextStyle(color: Colors.black),),
				iconTheme: IconThemeData(
					color: Colors.black,
				),
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
			  			height: size.height / 1.5,
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
			        								subtitle: buildIntake("2020-06-03", "breakfast"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																(context) => Meal(mealName: "Breakfast", date: "2020-06-03"))),
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
			        								subtitle: buildIntake("2020-06-03", "lunch"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Lunch",date: "2020-06-03"))),
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
			        								subtitle: buildIntake("2020-06-03", "dinner"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Dinner",date: "2020-06-03"))),
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
			        								subtitle: buildIntake("2020-06-04", "breakfast"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Breakfast",date: "2020-06-04"))),
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
			        								subtitle: buildIntake("2020-06-04", "lunch"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Lunch",date: "2020-06-04"))),
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
			        								subtitle: buildIntake("2020-06-04", "dinner"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Dinner",date: "2020-06-04"))),
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
			        								subtitle: buildIntake("2020-06-05", "breakfast"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Breakfast",date: "2020-06-05"))),
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
			        								subtitle: buildIntake("2020-06-05", "lunch"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Lunch",date: "2020-06-05"))),
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
			        								subtitle: buildIntake("2020-06-05", "dinner"),
															trailing: GestureDetector(
																child: Icon(Icons.navigate_next,),
																onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																		(context) => Meal(mealName: "Dinner",date: "2020-06-05"))),
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
						//buildChart(data),
			    ],
			  ),
			),
		);
	}

	Widget buildIntake(String date, String title){
		return Padding(
		  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
		  child: StreamBuilder(
		  		stream: Firestore.instance.collection(title).where
		  			("token", isEqualTo: token).where("date", isEqualTo: date).snapshots(),
		  		builder: (context, snapshot) {
		  			if(snapshot.hasData){
		  				if(snapshot.data.documents.length == 0){
								return Text("Not yet choose");
							}
		  				DocumentSnapshot ds = snapshot.data.documents[0];
							List<String> productName = List.from(ds['product']);

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
		  			else return Container(child: Center(child: CircularProgressIndicator()));
		  		}
		  ),
		);
	}

	/*Widget buildChart(List<Diet> data) {
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
	}*/

	getData() async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		token = prefs.getString("token");
	}

}