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
    final cartTotal = cart.total;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    '\$${cartTotal.toStringAsFixed(2)}',
                  ),
                  backgroundColor: Colors.amber,
                ),
                const Spacer(),
                OrderWidget(cart: cart, cartTotal: cartTotal),
              ],
            ),
          ),
        ),
        const SizedBox(
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

class OrderWidget extends StatefulWidget {
  const OrderWidget({
    Key key,
    @required this.cart,
    @required this.cartTotal,
  }) : super(key: key);

  final Cart cart;
  final double cartTotal;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? const RefreshProgressIndicator()
          : const Text(
              'ORDER NOW',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
      onPressed: (widget.cart.total <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.mapItems.values.toList(), widget.cartTotal);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
