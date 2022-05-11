import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class OrderItem {
  String id;
  double amount;
  List<CartItem> items;
  DateTime dateTime;

  OrderItem({this.id, this.amount, this.items, this.dateTime});
}

class Orders with ChangeNotifier {
  static const ordersRout = '/orders';
  List<OrderItem> orderItems = [];

  List<OrderItem> get orders {
    return [...orderItems];
  }

  void addOrder(List<CartItem> items, double total) {
    orderItems.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          items: items,
          dateTime: DateTime.now()),
    );
    notifyListeners();
  }
}
