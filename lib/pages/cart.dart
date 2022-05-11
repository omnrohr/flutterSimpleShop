import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_items.dart';
import '../models/cart.dart' show Cart;
import '../models/order.dart';

class CartView extends StatelessWidget {
  static const cartRout = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    '\$${cart.total.toStringAsFixed(2)}',
                  ),
                  backgroundColor: Colors.amber,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false)
                        .addOrder(cart.mapItems.values.toList(), cart.total);
                    cart.clear();
                  },
                  child: Text(
                    'ORDER NOW',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) =>
                  CartItemsView(cart.mapItems.values.toList()[index]),
              itemCount: cart.mapItems.length),
        ),
      ]),
    );
  }
}
