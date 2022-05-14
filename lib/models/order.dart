import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import './cart.dart';

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

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://shopapp-b795e-default-rtdb.firebaseio.com/orders.json');
    final fetchedOrders = await http.get(url);
    final serverData = json.decode(fetchedOrders.body) as Map<String, dynamic>;
    List<OrderItem> loadedOrders = [];
    if (fetchedOrders == null) return;
    serverData.forEach(((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        items: (orderData['items'] as List<dynamic>)
            .map((orderItem) => CartItem(
                id: orderItem['id'],
                title: orderItem['title'],
                price: orderItem['price'],
                quantity: orderItem['quantity']))
            .toList(),
      ));
    }));
    orderItems = loadedOrders.reversed.toList();
    notifyListeners();

    // print(serverData);
  }

  Future<void> addOrder(List<CartItem> items, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://shopapp-b795e-default-rtdb.firebaseio.com/orders.json');

    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'items': items
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'price': e.price,
                    'quantity': e.quantity,
                  })
              .toList(),
        }));

    orderItems.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          items: items,
          dateTime: timeStamp),
    );
    notifyListeners();
  }
}
