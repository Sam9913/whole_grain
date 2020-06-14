import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class AddFood extends StatefulWidget {
	@override
	_AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
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
	String dropdownValue;
	List<String> item = List<String>();
	List<String> itemId = List<String>();
	String productTypeID, fileName, filePath, zero = "0000";
	StorageReference storageReference;

	@override
	void initState() {
		super.initState();
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
				title: Text("Add Product", style: TextStyle(color: Colors.black)),
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body: SingleChildScrollView(
			  child: Padding(
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
			    		  			child:  Align(
													alignment: Alignment.bottomRight,
													child: Icon(Icons.photo_camera, color: Colors.black,)),
			    		  			onTap: (){
			    		  				getImage();
			    		  			},
			    		  		),
			    		  		backgroundColor: Colors.greenAccent.withOpacity(0.5),
									backgroundImage: _imageFile==null ? NetworkImage("") : FileImage(_imageFile),
								),
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

			    		StreamBuilder(
								stream: Firestore.instance.collection("product_type").snapshots(),
								builder: (context, snapshot){
									if(snapshot.hasData){
										for(int i = 0 ; i < snapshot.data.documents.length && !item.contains(snapshot.data.documents[i]["Name"]); i ++){
											item.add(snapshot.data.documents[i]["Name"]);
											itemId.add(snapshot.data.documents[i].documentID);
										}
										return Align(
											alignment: Alignment.centerLeft,
										  child: Padding(
										    padding: const EdgeInsets.only(top: 8.0),
										    child: Row(
										      children: <Widget>[
													Text("Product type: ", style: TextStyle(fontSize: 16),),
										        DropdownButton<String>(
										        	value: dropdownValue,
										        	icon: Icon(Icons.keyboard_arrow_down,color: Colors.green,),
										        	iconSize: 24,
										        	elevation: 16,
										        	style: TextStyle(color: Colors.black,fontSize: 16),
										        	underline: Container(
										        		height: 2,
										        		color: Colors.green,
										        	),
										        	onChanged: (String newValue) {
										        		setState(() {
										        			dropdownValue = newValue;
										        			for (int i = 0; i < item.length; i++) {
										        				if (newValue == item[i]) {
										        					productTypeID = itemId[i].toString();
										        					filePath = newValue;
										        				}
										        			}
										        		});
										        	},
										        	items: item.map<DropdownMenuItem<String>>(
										        					(String value) {
										        				return DropdownMenuItem<String>(
										        					value: value,
										        					child: Text(value,),
										        				);
										        			}).toList(),
										        ),
										      ],
										    ),
										  ),
										);
									}
									return Text("Loading...");
								},
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
							  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
							  child: Container(
			    			child: FlatButton(
									onPressed: () async{
											if(filePath == "Biscuit, cookie & chips")
												filePath = "Biscuit, cookie, chips";
											else if(filePath == "Bread, cake & muffin")
												filePath = "Bread, Cake _Muffin";
											else if(filePath == "Other")
												filePath = "Other grain and grain product";
											else if(filePath == "Ready to eat")
												filePath = "Ready to eat cereal, muesli, snack bar";

											DocumentReference dr =
											Firestore.instance.collection('product_type').document(productTypeID);
											QuerySnapshot querySnapshot = await Firestore.instance.collection('product')
													.where("product_type", isEqualTo: dr).getDocuments();
											int length = querySnapshot.documents.length;

											String id = length.toString().length < 4 ? zero.substring(0, 4 - length.toString().length) + length.toString() : length.toString();

   										storageReference =
													FirebaseStorage.instance.ref().child("Pictures - $filePath /$fileName");
											final StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
											final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
											final String url = (await downloadUrl.ref.getDownloadURL());

											Firestore.instance.collection("product").document(id).setData({
												"product_name":nameController.text,
												"image":"$url",
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
			    				child: Text("Add Food"),
			    			),
			    			decoration: BoxDecoration(
			    				borderRadius: BorderRadius.circular(10.0),
			    				color: Colors.greenAccent,
			    			),
			    		),
							),
			    	],
			    ),
			  ),
			),
		);
	}

	Future getImage() async {
		var image = await ImagePicker.pickImage(source: ImageSource.gallery);

		setState(() {
			_imageFile = image;
			fileName = p.basename(_imageFile.path);
			print(fileName);
		});
	}
}
