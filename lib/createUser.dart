import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUser extends StatelessWidget {
  final databaseReference = Firestore.instance;
  static int id = 0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void createRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    await databaseReference.collection("user")
        .document("1")
        .setData({
      'email': email,
    });

    DocumentReference ref = await databaseReference.collection("user")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  }

  void getData() {
  databaseReference
      .collection("books")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
  snapshot.documents.forEach((f) => print('${f.data}}'));
  });
  }

  void updateData() {
    try {
      databaseReference
          .collection('user')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

}
