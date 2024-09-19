import 'package:flutter/material.dart';

class ProdDesc extends StatelessWidget {
  ProdDesc({Key? key}) : super(key: key);
  Map<String, dynamic> productdetail = {};

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    productdetail = args['productdetail'];
    return Scaffold(
        backgroundColor: Color(0xfff8f6e8),
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Color(0xffffffff),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(productdetail['image'],
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _productdetail(productdetail, context)
                ],
              )),
        )));
  }

  _productdetail(product, context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "${product['brand']}  ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${product['name']}",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Rs. ${product['price']}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "PRODUCT DESCRIPTION",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        _rowdes("Detail", product['description'], context),
        SizedBox(
          height: 10,
        ),
        _rowdes("Brand ", product['brand'], context),
      ],
    );
  }

  _rowdes(fieldname, fieldvalue, context) {
    return Row(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              children: [
                Text(
                  "${fieldname} :  ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )),
        Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              children: [
                Text(
                  fieldvalue,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.normal),
                )
              ],
            ))
      ],
    );
  }
}
