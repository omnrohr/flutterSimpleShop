import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartItemsView extends StatelessWidget {
  CartItem cartItemView;
  CartItemsView(this.cartItemView);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_direction) {
        print('calling remove item');
        Provider.of<Cart>(context, listen: false).removeItem(cartItemView);
      },
      key: ValueKey(cartItemView.id),
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('\$${cartItemView.price}')),
            ),
            title: Text(
              cartItemView.title,
              style: TextStyle(fontSize: 20),
            ),
            subtitle:
                Text('Total: \$${cartItemView.quantity * cartItemView.price}'),
            trailing: Text('x ${cartItemView.quantity}'),
          ),
        ),
      ),
    );
  }
}
