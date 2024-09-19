import 'package:flutter/material.dart';
import 'package:assignment/provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<dynamic, dynamic> products = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<EcomProvider>(builder: (context, prov_ecom, child) {
          print("Length is ${prov_ecom.cartItem.length}");
          if (prov_ecom.cartItem.isEmpty) {
            return Center(child: Text("Cart is empty"));
          } else if (prov_ecom.cartItem.length > 0) {
            return Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var productId =
                              prov_ecom.cartItem.keys.elementAt(index);
                          return ListTile(
                              leading: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image.network(
                                      prov_ecom.cartItem[productId]['image'])),
                              title: InkWell(
                                  child: Text(
                                    prov_ecom.cartItem[productId]['name'],
                                    maxLines: 1, // Limit to 2 lines
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed('proddesc',
                                        arguments: {
                                          'productdetail':
                                              prov_ecom.cartItem[productId]
                                        });
                                  }),
                              subtitle: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Rs. ${prov_ecom.cartItem[productId]['price']}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: _cartbutton(productId,
                                          prov_ecom.cartItem[productId]),
                                    )
                                  ],
                                ),
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: prov_ecom.cartItem.length)));
          } else
            return Text("Cart is empty");
        })
        //)
        );
  }

  Widget _cartbutton(prodid, prod) {
    return Consumer<EcomProvider>(builder: (context, prov_ecom, child) {
      prov_ecom.count(prodid, prod);
      return Row(
        children: [
          ElevatedButton(
              onPressed: () {
                prov_ecom.decrement(prodid, prod);
              },
              child: Text("-")),
          Text("${prov_ecom.itemCount}"),
          ElevatedButton(
              onPressed: () {
                prov_ecom.increment(prodid, prod);
              },
              child: Text("+")),
        ],
      );
    });
  }
}
