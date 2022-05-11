import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../widgets/order_item.dart' as order_widget;
import '../widgets/app_drawer.dart';

class OrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Your Orders')),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: orders.orderItems.length,
          itemBuilder: (_, i) => order_widget.OrderItem(orders.orderItems[i]),
        ));
  }
}
