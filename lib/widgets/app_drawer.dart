import 'package:flutter/material.dart';
import 'package:myapp/models/order.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('hello'),
            automaticallyImplyLeading: false,
            //back button disabled
          ),
          Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Orders.ordersRout);
            },
          ),
        ],
      ),
    );
  }
}
