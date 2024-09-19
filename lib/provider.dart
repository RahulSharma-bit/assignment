import 'package:flutter/material.dart';

class EcomProvider extends ChangeNotifier {
  Map<dynamic, dynamic> _cartItem = {};
  Map<dynamic, dynamic> get cartItem => _cartItem;

  int _itemCount = 0;
  int get itemCount => _itemCount;

  dynamic count(prodId, prod) {
    _itemCount =
        (cartItem.containsKey(prodId)) ? cartItem[prodId]['quantity'] : 0;
    notifyListeners();
  }

  increment(prodId, prod) {
    if (cartItem.containsKey(prodId)) {
      cartItem[prodId]['quantity'] += 1;
    } else {
      cartItem[prodId] = prod;
      cartItem[prodId]['quantity'] = 1;
    }
    count(prodId, prod);
    notifyListeners();
  }

  decrement(prodId, prod) {
    if (cartItem.containsKey(prodId) && cartItem[prodId]['quantity'] > 1) {
      cartItem[prodId]['quantity'] -= 1;
    } else if (cartItem.containsKey(prodId) &&
        cartItem[prodId]['quantity'] == 1) {
      cartItem.remove(prodId);
    }
    count(prodId, prod);
    notifyListeners();
  }
}
