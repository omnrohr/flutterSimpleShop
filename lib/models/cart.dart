import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  // final Product product;
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _mapItems = {};
  // List<CartItem> _items;
  String id;

  // List<CartItem> get items {
  //   return _mapItems.values.toList();
  // }

  Map<String, CartItem> get mapItems {
    return {..._mapItems};
  }

  void addItemToCart(String productId, double price, String title) {
    if (_mapItems.containsKey(productId)) {
      _mapItems[productId].quantity += 1;
    } else {
      _mapItems.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  int get count {
    return _mapItems == null ? 0 : _mapItems.length;
  }

  double get total {
    double total = 0;
    _mapItems.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void removeItem(CartItem item) {
    _mapItems.removeWhere((key, value) {
      return value == item;
    });
    notifyListeners();
  }

  void clear() {
    _mapItems = {};
    notifyListeners();
  }
}
