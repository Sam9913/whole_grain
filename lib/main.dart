import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wholegrain/WholeGrain.dart';
import 'package:wholegrain/home.dart';
import 'package:wholegrain/pinScreen.dart';
import 'package:wholegrain/search.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      theme: ThemeData(
        // Define the default brightness and colors.
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
  GoogleSignInAccount _currentUser;
  bool loading = false;
  int _currentPage = 0;
  bool pressLogin = false;
  bool pressRegister = false;
  final mailController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Container(
          height: 592,
          width: 350,
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
                width: 300,
                child: Text(
                  "Welcome, ",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 300,
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
                width: 300,
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

                              if(mailController.text == "kosupure2019@gmail.com")
                                _continue(mailController.text);
                              else
                                _login(mailController.text);
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

  void _continue(String email) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PinEnter()),);
  }

  void _login(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    /*if(id == 0 ){
      getData();
    }
    print(id.toString());

    await databaseReference.collection("user").document(id.toString()).setData({
      'email': email,
    });

    DocumentReference ref = await databaseReference.collection("user").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);*/

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WholeGrain()));
  }
}
