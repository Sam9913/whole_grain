import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
	@override
	_AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
	List<TextEditingController> detailsController = List<TextEditingController>(16);
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
	}

	@override
	void dispose() {
		super.dispose();
		nameController.dispose();
		for(TextEditingController controller in detailsController){
			controller.dispose();
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
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: <Widget>[
					CircleAvatar(
							child: GestureDetector(
								child: Icon(Icons.photo_camera),
								onTap: (){
									getImage();
								},
							),
							backgroundColor: Colors.lightGreen,),
					TextField(
						controller: nameController,
						decoration: InputDecoration(
							labelText: "Name",
						),
					),
					ListView.builder(
						shrinkWrap: true,
						itemCount: detailsController.length,
						itemBuilder: (context, index){
							return TextField(
								controller: detailsController[index],
								decoration: InputDecoration(
									labelText: detailsName[index],
								),
							);
						},
					),
					Container(
						child: FlatButton(
							child: Text("Update information"),
						),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(10.0),
							color: Colors.greenAccent,
						),
					),
				],
			),
		);
	}

	Future getImage() async {
		var image = await ImagePicker.pickImage(source: ImageSource.gallery);

		setState(() {
			_imageFile = image;
		});
	}
}
