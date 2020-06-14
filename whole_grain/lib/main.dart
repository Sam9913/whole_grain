import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
import 'PinEnter.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future main() async{
	WidgetsFlutterBinding.ensureInitialized();

	SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
	var checkLogin = sharedPreferences.getString("token");
	print(checkLogin);
	runApp(MaterialApp(home: checkLogin == null ? MyApp() : Home()));
}

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Login(),
			theme: ThemeData(
				brightness: Brightness.light,
				primaryColor: Colors.greenAccent,

				// Define the default font family.
				fontFamily: 'Arial',
			),
		);
	}
}

class Login extends StatefulWidget {
	@override
	_LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
	bool loading = false;
	bool pressLogin = false;
	bool pressRegister = false;
	final mailController = TextEditingController();

	@override
	void dispose() {
		mailController.dispose();
		super.dispose();
	}

		void _continue(String email) async {
			SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString('email', email);

			Navigator.pushReplacement(
				context, MaterialPageRoute(
					builder: (BuildContext context) => PinEnter()),);
		}

		void _login(String email) async {
			SharedPreferences prefs = await SharedPreferences.getInstance();

			QuerySnapshot existQuery = await Firestore.instance.collection("user").where("email",
					isEqualTo: email).getDocuments();

			if (existQuery.documents.isEmpty) {
				DocumentReference documentReference = await Firestore.instance.collection("user").add({
					'email': email,
				});
				prefs.setString('token', documentReference.documentID);
				prefs.setStringList("date", [DateTime.now().toString().substring(0,10)]);
				Fluttertoast.showToast(
						msg: "Hi, welcome new user!",
						toastLength: Toast.LENGTH_SHORT,
						gravity: ToastGravity.BOTTOM,
						timeInSecForIosWeb: 1,
						backgroundColor: Colors.black,
						textColor: Colors.white);
			}
			else{
				List<String> date = prefs.getStringList("date") != null ? prefs.getStringList("date") :
				List<String>() ;
				date.add(DateTime.now().toString().substring(0,10));
				prefs.setStringList("date", date);
				prefs.setString('token', existQuery.documents[0].documentID);
				Fluttertoast.showToast(
						msg: "Welcome back!",
						toastLength: Toast.LENGTH_SHORT,
						gravity: ToastGravity.BOTTOM,
						timeInSecForIosWeb: 1,
						backgroundColor: Colors.black,
						textColor: Colors.white);
			}

			Navigator.of(context).pushReplacement(
				MaterialPageRoute(builder: (context) => Home(),),
			);
		}

  @override
  Widget build(BuildContext context) {
		var size = MediaQuery
				.of(context)
				.size;

		return Scaffold(
			backgroundColor: Colors.greenAccent,
			body: SingleChildScrollView(
				child: Container(
					height: 592,
					width: size.width,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.center,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Container(
									width: 120.0,
									child: Center(child: ClipOval(child: Image.asset("data_repo/logo.png"))),
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Colors.white,
										boxShadow: [
											BoxShadow(
													color: Colors.white30,
													blurRadius: 10.0,
													offset: Offset(4.0, 4.0),
													spreadRadius: 5.0)
										],
									),
								),
							),
							SizedBox(
								child: Text(
									"Welcome, ",
									style: TextStyle(
											fontWeight: FontWeight.w900,
											fontSize: 24,
											color: Colors.white),
								),
							),
							SizedBox(
								child: Padding(
									padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
									child: Text(
										"Enter email to continue",
										style: TextStyle(
												fontSize: 16,
												color: Colors.white,
												fontWeight: FontWeight.w700),
									),
								),
							),
							Container(
								height: 140,
								width: size.width - 50,
								decoration: BoxDecoration(
									borderRadius: new BorderRadius.circular(20.0),
									color: Colors.white,
								),
								child: Padding(
									padding: const EdgeInsets.all(16.0),
									child: Column(
										mainAxisAlignment: MainAxisAlignment.center,
										crossAxisAlignment: CrossAxisAlignment.center,
										children: <Widget>[
											Row(
												children: <Widget>[
													Flexible(
														child: TextField(
															controller: mailController,
															decoration: const InputDecoration(
																suffixIcon: Icon(
																	Icons.mail,
																	color: Colors.greenAccent,
																),
																labelText: 'Email',
																labelStyle: TextStyle(color: Colors.black),
																hintText: 'abc@gmail.com',
																contentPadding: const EdgeInsets.symmetric(
																		vertical: 10.0, horizontal: 10.0),
															),
															style: TextStyle(fontSize: 14),
														),
													),
												],
											),
											SizedBox(
												width: 270,
												child: Padding(
													padding:
													const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
													child: RaisedButton(
														onPressed: () {
															setState(() {
																pressLogin = true;
															});

															if (mailController.text == "kosupure2019@gmail.com")
																_continue(mailController.text);
															else if (mailController.text.isNotEmpty)
																_login(mailController.text);
															else
																Fluttertoast.showToast(
																	msg: "Incorrect email",
																	toastLength: Toast.LENGTH_SHORT,
																	gravity: ToastGravity.BOTTOM,
																	timeInSecForIosWeb: 1,
																	backgroundColor: Colors.black,
																	textColor: Colors.white,
																);
														},
														color:
														pressLogin ? Colors.white : Colors.greenAccent,
														shape: RoundedRectangleBorder(
															borderRadius: new BorderRadius.circular(18.0),
															side: BorderSide(color: Colors.greenAccent),
														),
														child: Text(
															"Next",
															style: TextStyle(color: Colors.black),
														),
													),
												),
											),
										],
									),
								),
							),
						],
					),
				),
			),
		);
  }
}
