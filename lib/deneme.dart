import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? userName;

  @override
  void initState() {
    super.initState();
    // Firestore'dan kullanıcı adını al
    FirebaseFirestore.instance
        .collection('deneme')
        .doc('xyjVURj6gxoP2gCtO07S') // user_id burada kullanıcının belirli bir kimliği olacak
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          userName = documentSnapshot['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: userName != null
            ? Text('Hello, $userName!')
            : CircularProgressIndicator(),
      ),
    );
  }
}
