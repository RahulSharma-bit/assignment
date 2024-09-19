import 'package:flutter/material.dart';
import 'package:assignment/cart.dart';
import 'package:assignment/ecom.dart';
import 'package:assignment/ecom_home.dart';
import 'package:assignment/prod_desc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'ecom',
      routes: {'ecom': (context) => ecom()},
    );
  }
}
