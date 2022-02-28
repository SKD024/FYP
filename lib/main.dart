import 'package:bookbinnepal/present/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookBinNepal',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: loginpage(),
    );
  }
}
