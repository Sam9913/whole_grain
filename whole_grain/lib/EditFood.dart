import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditFood extends StatefulWidget {
	final String productName;

  const EditFood({Key key, this.productName}) : super(key: key);

  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
	List<TextEditingController> detailsController = [
		for (int i = 1; i < 16; i++)
			TextEditingController()
	];
	TextEditingController nameController = TextEditingController();
	File _imageFile;
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
	
	@override
  void initState() {
    super.initState();
    nameController.text = widget.productName;
    getDetails();
  }

	@override
  void dispose() {
    super.dispose();
    nameController.dispose();
		for(int i = 0 ; i < detailsController.length ; i++){
			detailsController[i].dispose();
		}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.greenAccent,
				title: Text(widget.productName, style: TextStyle(color: Colors.black)),
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body: SingleChildScrollView(
			  child: StreamBuilder(
			  	stream: Firestore.instance
			  			.collection('product')
			  			.where('product_name', isEqualTo: widget.productName)
			  			.snapshots(),
			  	builder: (context, snapshot) {
			  		if(snapshot.hasData){
							DocumentSnapshot ds = snapshot.data.documents[0];
			  			return Padding(
			  			  padding: const EdgeInsets.all(8.0),
			  			  child: Column(
			  			  	mainAxisAlignment: MainAxisAlignment.center,
			  			  	crossAxisAlignment: CrossAxisAlignment.center,
			  			  	children: <Widget>[
			  			  		Padding(
			  			  		  padding: const EdgeInsets.all(8.0),
			  			  		  child: CircleAvatar(
										radius: 50,
			  			  		  	child: GestureDetector(
			  			  		  		child: Align(
													alignment: Alignment.bottomRight,
													child: Icon(Icons.photo_camera, color: Colors.black,)),
			  			  		  		onTap: (){
			  			  		  			getImage();
			  			  		  		},
			  			  		  	),
			  			  		  		backgroundImage: NetworkImage(
			  			  		  			ds['image'].toString(),
			  			  		  		)),
			  			  		),
			  			  		Padding(
											padding: const EdgeInsets.all(8.0),
											child: Align(
													alignment: Alignment.centerLeft,
													child: Text("Remarks for value: \n=> -1 = Blank value\n=> -2 = Trace",
														style:
						TextStyle(color: Colors.black.withOpacity(0.7)),)),
										),
			  			  		Padding(
			  			  		  padding: const EdgeInsets.only(top: 8.0),
			  			  		  child: TextField(
			  			  		  	controller: nameController,
			  			  		  	decoration: InputDecoration(
			  			  		  		labelText: "Name",
			  			  		  	),
			  			  		  ),
			  			  		),
			  			  		ListView.builder(
											physics: NeverScrollableScrollPhysics(),
			  			  			shrinkWrap: true,
			  			  			itemCount: detailsController.length,
			  			  			itemBuilder: (context, index){
			  			  				return Padding(
			  			  				  padding: const EdgeInsets.only(top: 8.0),
			  			  				  child: TextField(
			  			  				  	controller: detailsController[index],
			  			  				  	decoration: InputDecoration(
			  			  				  		labelText: detailsName[index],
			  			  				  	),
			  			  				  ),
			  			  				);
			  			  			},
			  			  		),
			  			  		Padding(
			  			  		  padding: const EdgeInsets.all(8.0),
			  			  		  child: Container(
			  			  		  	child: FlatButton(
													onPressed: (){
														Firestore.instance.collection("product").document(ds.documentID).updateData({
															"product_name" : nameController.text,
														"serving_size" : double.parse(detailsController[0].text),
														"totalWG_content_per_serving" : double.parse(detailsController[1].text),
														"totalWG_content" : double.parse(detailsController[2].text),
														"kcal_per_serving" : double.parse(detailsController[3].text),
														"total_fat" : double.parse(detailsController[4].text),
														"saturated_fat" : double.parse(detailsController[5].text),
														"monounsaturated_fat" : double.parse(detailsController[6].text),
														"polyunsaturated_fat" : double.parse(detailsController[7].text),
														"carbohydrate" : double.parse(detailsController[8].text),
														"fibre" : double.parse(detailsController[9].text),
														"total_sugar" : double.parse(detailsController[10].text),
														"protein" : double.parse(detailsController[11].text),
														"sodium" : double.parse(detailsController[12].text),
														"potassium" : double.parse(detailsController[13].text),
														"calcium" : double.parse(detailsController[14].text),
														"iron" : double.parse(detailsController[15].text),
														});
													},
			  			  		  		child: Text("Update information"),
			  			  		  	),
			  			  		  	decoration: BoxDecoration(
			  			  		  		borderRadius: BorderRadius.circular(10.0),
			  			  		  		color: Colors.greenAccent,
			  			  		  	),
			  			  		  ),
			  			  		),
			  			  	],
			  			  ),
			  			);
			  		}
			  		return Container(child: Center(child: CircularProgressIndicator(),),);
			  	}
			  ),
			),
		);
  }

	Future getImage() async {
		var image = await ImagePicker.pickImage(source: ImageSource.gallery);

		setState(() {
			_imageFile = image;
		});
	}

	getDetails() async {
		QuerySnapshot querySnapshot = await Firestore.instance
				.collection('product')
				.where("product_name", isEqualTo: widget.productName)
				.getDocuments();

		detailsController[0].text = querySnapshot.documents[0]["serving_size"].toString();
		detailsController[1].text = querySnapshot.documents[0]['totalWG_content_per_serving'].toString();
		detailsController[2].text = querySnapshot.documents[0]['totalWG_content'].toString();
		detailsController[3].text = querySnapshot.documents[0]['kcal_per_serving'].toString();
		detailsController[4].text = querySnapshot.documents[0]['total_fat'].toString();
		detailsController[5].text = querySnapshot.documents[0]['saturated_fat'].toString();
		detailsController[6].text = querySnapshot.documents[0]['monounsaturated_fat'].toString();
		detailsController[7].text = querySnapshot.documents[0]['polyunsaturated_fat'].toString();
		detailsController[8].text = querySnapshot.documents[0]['carbohydrate'].toString();
		detailsController[9].text = querySnapshot.documents[0]['fibre'].toString();
		detailsController[10].text = querySnapshot.documents[0]['total_sugar'].toString();
		detailsController[11].text = querySnapshot.documents[0]['protein'].toString();
		detailsController[12].text = querySnapshot.documents[0]['sodium'].toString();
		detailsController[13].text = querySnapshot.documents[0]['potassium'].toString();
		detailsController[14].text = querySnapshot.documents[0]['calcium'].toString();
		detailsController[15].text = querySnapshot.documents[0]['iron'].toString();
	}
}
