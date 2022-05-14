import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../widgets/order_item.dart' as order_widget;
import '../widgets/app_drawer.dart';

class OrdersView extends StatefulWidget {
  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  // bool _isLoading = false; // change to future builder from flutter

  Future _futureProvider;
  Future _orderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    _futureProvider = _orderFuture();
    // i will go with future builder from flutter
    // Future.delayed(Duration.zero).then((value) async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   await Provider.of<Orders>(context, listen: false).fetchOrders();
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    super.initState();
  }

  // another way of getting data
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
    // final orders = Provider.of<Orders>(context); with this is enabled you will keep in infinite loop. check the course.
    return Scaffold(
        appBar: AppBar(title: const Text('Your Orders')),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _futureProvider,
            builder: (ctx, snapShots) {
              if (snapShots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShots.error != null) {
                return const Center(
                  child: Text('Error please try again'),
                );
              } else {
                return Consumer<Orders>(
                  builder: ((ctx, orders, _) => ListView.builder(
                        itemCount: orders.orderItems.length,
                        itemBuilder: (_, i) =>
                            order_widget.OrderItem(orders.orderItems[i]),
                      )),
                );
              }
            }));
  }
}
