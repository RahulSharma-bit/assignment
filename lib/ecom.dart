import 'package:flutter/material.dart';
import 'package:assignment/cart.dart';
import 'package:assignment/ecom_home.dart';
import 'package:assignment/prod_desc.dart';
import 'package:assignment/provider.dart';
import 'package:provider/provider.dart';

class ecom extends StatelessWidget {
  const ecom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EcomProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'ecomhome',
          routes: {
            'ecomhome': (context) => EcomHome(),
            'proddesc': (context) => ProdDesc(),
            'cart': (context) => Cart()
          },
        ));
  }
}
