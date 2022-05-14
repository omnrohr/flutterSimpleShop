import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../widgets/order_item.dart' as order_widget;
import '../widgets/app_drawer.dart';

class OrdersView extends StatefulWidget {
  @override
  State<OrdersView> createState() => approach();
}

class approach extends State<OrdersView> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });
  }

  // another approach
  //   if (this.mounted) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //   }
  //   Provider.of<Orders>(context, listen: false).fetchOrders().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  // @override
  // void setState(VoidCallback fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Your Orders')),
        drawer: AppDrawer(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: orders.orderItems.length,
                itemBuilder: (_, i) =>
                    order_widget.OrderItem(orders.orderItems[i]),
              ));
  }
}
