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
    nameController.text = widget.productName;
    getDetails();
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
				title: Text(widget.productName, style: TextStyle(color: Colors.black)),
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body: StreamBuilder(
				stream: Firestore.instance
						.collection('product')
						.where("product_name", isEqualTo: widget.productName)
						.snapshots(),
				builder: (context, snapshot) {
					DocumentSnapshot ds = snapshot.data.documents[snapshot];
					if(snapshot.hasData){
						return Column(
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
										backgroundImage: NetworkImage(
											ds['image'].toString(),
										)),
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
						);
					}
					return Container(child: Center(child: CircularProgressIndicator(),),);
				}
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
