import 'dart:convert';
// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:assignment/provider.dart';

class EcomHome extends StatefulWidget {
  const EcomHome({super.key});

  @override
  State<EcomHome> createState() => _EcomHomeState();
}

class _EcomHomeState extends State<EcomHome> {
  List<dynamic> products = [];

  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    fetchproducts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('cart');
                },
                child: const Icon(Icons.shopping_cart))
          ],
        ),
        body: products.isEmpty
            ? Center(
                child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.05,
                child: const CircularProgressIndicator(),
              ))
            : products.length > 0
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.47, // Aspect ratio for each item
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                Container(
                                    child: Image.network(
                                  products[index]['image'],
                                  fit: BoxFit.contain,
                                  //)
                                )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: InkWell(
                                        child: Text(
                                          products[index]['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2, // Limit to 2 lines
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              'proddesc',
                                              arguments: {
                                                'productdetail': products[index]
                                              });
                                        })),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Align(
                                        child: Text(
                                            "Rs. ${products[index]['price']}"),
                                        alignment: Alignment.topLeft)),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                    child: _cartbutton(products[index]),
                                    alignment: Alignment.center),
                                const SizedBox(
                                  height: 20,
                                ),
                              ])));
                    },
                    itemCount: products.length)
                : const Text("PRODUCTS ARE EMPTY")
        //, )
        );
  }

  void fetchproducts() async {
    final url = 'https://freetestapi.com/api/v1/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      products = json;
    });
  }

  Widget _cartbutton(prod) {
    return Consumer<EcomProvider>(builder: (context, prov_ecom, child) {
      prov_ecom.count(prod['id'], prod);
      return Row(
        children: [
          ElevatedButton(
              onPressed: () {
                prov_ecom.decrement(prod['id'], prod);
              },
              child: Text("-")),
          Text("${prov_ecom.itemCount}"),
          ElevatedButton(
              onPressed: () {
                prov_ecom.increment(prod['id'], prod);
              },
              child: const Text("+")),
        ],
      );
    });
  }
}
