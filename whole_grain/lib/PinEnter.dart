import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarc/Home.dart';

class PinEnter extends StatefulWidget {
	@override
	_PinEnterState createState() => _PinEnterState();
}

class _PinEnterState extends State<PinEnter> {
	TextEditingController pinController = TextEditingController();
	String currentText = "";
	final databaseReference = Firestore.instance;
	static int id = 0;
	StreamController<ErrorAnimationType> errorController;

	@override
	void dispose() {
		errorController.close();
		super.dispose();
	}


	@override
	void initState() {
		// TODO: implement initState
		errorController = StreamController<ErrorAnimationType>.broadcast();
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				color: Colors.greenAccent,
				height: 592,
				width: 400,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Text(
							"Welcome back, Admin",
							style: TextStyle(
									fontWeight: FontWeight.w900,
									fontSize: 24,
									color: Colors.white),
						),
						Text(
							"Enter pin number to login",
							style: TextStyle(
									fontSize: 16,
									color: Colors.white,
									fontWeight: FontWeight.w700),
						),
						Padding(
							padding: const EdgeInsets.fromLTRB(5.0,8.0,5.0,8.0),
							child: Container(
								height: 90,
								width: 350,
								decoration: BoxDecoration(
									borderRadius: new BorderRadius.circular(20.0),
									color: Colors.white,
								),
								child: Center(
									child: PinCodeTextField(
										mainAxisAlignment: MainAxisAlignment.spaceEvenly,
										backgroundColor: Colors.white,
										length: 6,
										animationType: AnimationType.fade,
										errorAnimationController: errorController,
										pinTheme: PinTheme(
											borderRadius: BorderRadius.circular(2.0),
											activeFillColor: Colors.white,
											activeColor: Colors.green,
											selectedFillColor: Colors.white,
											selectedColor: Colors.teal,
											inactiveFillColor: Colors.white,
											inactiveColor: Colors.greenAccent,
											fieldHeight: 50,
											fieldWidth: 40,
											shape: PinCodeFieldShape.box,
										),
										animationDuration: Duration(milliseconds: 300),
										enableActiveFill: true,
										controller: pinController,
										onCompleted: (v) {
											if(pinController.text != "123456"){
												errorController.add(ErrorAnimationType.shake);
												Fluttertoast.showToast(
													msg: "Try Again!",
													toastLength: Toast.LENGTH_SHORT,
													gravity: ToastGravity.BOTTOM,
													timeInSecForIosWeb: 1,
													backgroundColor: Colors.black,
													textColor: Colors.white,
												);
											}
											else{
												Fluttertoast.showToast(
													msg: "Welcome back!",
													toastLength: Toast.LENGTH_SHORT,
													gravity: ToastGravity.BOTTOM,
													timeInSecForIosWeb: 1,
													backgroundColor: Colors.black,
													textColor: Colors.white,
												);
												_login();
											}
										},
										onChanged: (value) {
											setState(() {
												currentText = value;
											});
										},
									),
								),
							),
						),
					],
				),
			),
		);
	}

	void getData() {
		databaseReference
				.collection("user")
				.getDocuments()
				.then((QuerySnapshot snapshot) {
			snapshot.documents.forEach((f) => id = int.parse(f.documentID) + 1 );
		});
	}

	void _login() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		String email = prefs.getString('email');

		if(id == 0 ){
			getData();
		}
		print(id.toString());

		/*await databaseReference.collection("user").document(id.toString()).setData({
      'email': email,
    });
    DocumentReference ref = await databaseReference.collection("user").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);*/

		Navigator.of(context).pushReplacement(
				MaterialPageRoute(builder: (BuildContext context) => Home()));
	}
}