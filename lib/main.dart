import 'package:flutter/material.dart';
import 'package:user_firestore/form_screen.dart';
import 'package:user_firestore/ui_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UIScreen(), //FormScreen(),
    );
  }
}
