import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarc/ShowAverage.dart';

import 'Meal.dart';

class DietIntake extends StatefulWidget {
	@override
	_DietIntakeState createState() => _DietIntakeState();
}

class _DietIntakeState extends State<DietIntake> with TickerProviderStateMixin {
	final List<Tab> myTabs = <Tab>[Tab(text: 'Day 1'), Tab(text: 'Day 2'), Tab(text: 'Day 3')];
	TabController _tabController;
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
	String token;
	List<String> date = List<String>();
	List<String> meal = ["breakfast","lunch","dinner"];

	@override
	void initState() {
		super.initState();
		getData();
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
			        			return ListView.builder(
											shrinkWrap: true,
												itemCount: meal.length,
												itemBuilder: (context, index){
												if(date.isEmpty){
													return Padding(
													  padding: const EdgeInsets.all(8.0),
													  child: Container(
													  	decoration: BoxDecoration(
													  		borderRadius: new BorderRadius.circular(10.0),
													  		color: Colors.grey.withOpacity(0.5),
													  	),
													    child: ListTile(
													    	title: Text(meal[index].substring(0,1).toUpperCase() + meal[index].substring(1)),
													    	subtitle: Text("Not yet choose"),
																trailing: GestureDetector(
																	child: Icon(Icons.navigate_next,),
																	onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																			(context) => Meal(mealName: meal[index].substring(0,1)
																			.toUpperCase() + meal[index].substring(1), date:
																	date[0]))),
																),
													    ),
													  ),
													);
												}
												return Padding(
												  padding: const EdgeInsets.all(8.0),
												  child: Container(
												  	decoration: BoxDecoration(
												  		borderRadius: new BorderRadius.circular(10.0),
												  		color: Colors.grey.withOpacity(0.5),
												  	),
												    child: ListTile(
												    	title: Text(meal[index].substring(0,1).toUpperCase() + meal[index].substring(1)),
												    	subtitle: buildIntake(date[0], meal[index]),
												    	trailing: GestureDetector(
												    		child: Icon(Icons.navigate_next,),
												    		onTap: () => Navigator.push(context, MaterialPageRoute(builder:
												    				(context) => Meal(mealName: meal[index].substring(0,1)
																				.toUpperCase() + meal[index].substring(1), date: date[0]))),
												    	),
												    ),
												  ),
												);
												});
			        		}
			        		else if (tab.text == 'Day 2'){
										return ListView.builder(
												shrinkWrap: true,
												itemCount: meal.length,
												itemBuilder: (context, index){
													if(date.length < 2){
														return Padding(
														  padding: const EdgeInsets.all(8.0),
														  child: Container(
														  	decoration: BoxDecoration(
														  		borderRadius: new BorderRadius.circular(10.0),
														  		color: Colors.grey.withOpacity(0.5),
														  	),
														    child: ListTile(
														    	title: Text(meal[index].substring(0,1).toUpperCase() + meal[index].substring(1)),
														    	subtitle: Text("Not yet choose"),
																	trailing: GestureDetector(
																		child: Icon(Icons.navigate_next,),
																		onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																				(context) => Meal(mealName: meal[index].substring(0,1)
																				.toUpperCase() + meal[index].substring(1), date:
																		date[1]))),
																	),
														    ),
														  ),
														);
													}
													return Padding(
													  padding: const EdgeInsets.all(8.0),
													  child: Container(
													  	decoration: BoxDecoration(
													  		borderRadius: new BorderRadius.circular(10.0),
													  		color: Colors.grey.withOpacity(0.5),
													  	),
													    child: ListTile(
													    	title: Text(meal[index].substring(0,1).toUpperCase() + meal[index].substring(1)),
													    	subtitle: buildIntake(date[1], meal[index]),
													    	trailing: GestureDetector(
													    		child: Icon(Icons.navigate_next,),
													    		onTap: () => Navigator.push(context, MaterialPageRoute(builder:
													    				(context) => Meal(mealName: meal[index].substring(0,1)
																					.toUpperCase() + meal[index].substring(1), date:
																			date[1]))),
													    	),
													    ),
													  ),
													);
												});
			        		}
			        		else{
										return ListView.builder(
												shrinkWrap: true,
												itemCount: meal.length,
												itemBuilder: (context, index){
													if(date.length < 3){
														return Padding(
														  padding: const EdgeInsets.all(8.0),
														  child: Container(
														  	decoration: BoxDecoration(
														  		borderRadius: new BorderRadius.circular(10.0),
														  		color: Colors.grey.withOpacity(0.5),
														  	),
														    child: ListTile(
														    	title: Text(meal[index].substring(0,1).toUpperCase() + meal[index].substring(1)),
														    	subtitle: Text("Not yet choose"),
																	trailing: GestureDetector(
																		child: Icon(Icons.navigate_next,),
																		onTap: () => Navigator.push(context, MaterialPageRoute(builder:
																				(context) => Meal(mealName: meal[index].substring(0,1)
																				.toUpperCase() + meal[index].substring(1), date:
																		date[2]))),
																	),
														    ),
														  ),
														);
													}
													return Padding(
													  padding: const EdgeInsets.all(8.0),
													  child: Container(
													  	decoration: BoxDecoration(
													  		borderRadius: new BorderRadius.circular(10.0),
													  		color: Colors.grey.withOpacity(0.5),
													  	),
													    child: ListTile(
													    	title: Text(meal[index].substring(0,1).toUpperCase() + meal[index].substring(1)),
													    	subtitle: buildIntake(date[2], meal[index]),
													    	trailing: GestureDetector(
													    		child: Icon(Icons.navigate_next,),
													    		onTap: () => Navigator.push(context, MaterialPageRoute(builder:
													    				(context) => Meal(mealName: meal[index].substring(0,1)
																					.toUpperCase() + meal[index].substring(1), date:
																			date[2]))),
													    	),
													    ),
													  ),
													);
												});
			        		}
			        	}).toList(),
			        ),
			      ),

						Container(
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(10.0),
								color: Colors.greenAccent,
							),
						  child: FlatButton(
						  		onPressed: (){
						  			Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
												ShowAverage()));
						  		},
						  		child: Text("Average")),
						),

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

	getData() async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		setState(() {
			token = prefs.getString("token");
			date = prefs.getStringList("date");
		});
	}

}