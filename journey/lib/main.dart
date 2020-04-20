// snippet: mateapp
import 'package:flutter/material.dart';
import 'package:journey/Maps.dart';
import 'package:journey/Login.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'journey',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}