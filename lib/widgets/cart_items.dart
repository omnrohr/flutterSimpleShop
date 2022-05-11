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
        Provider.of<Cart>(context, listen: false).removeItem(cartItemView);
      },
      key: ValueKey(cartItemView.id),
      background: Container(
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        margin: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('\$${cartItemView.price}')),
            ),
            title: Text(
              cartItemView.title,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle:
                Text('Total: \$${cartItemView.quantity * cartItemView.price}'),
            trailing: Text('x ${cartItemView.quantity}'),
          ),
        ),
      ),
      confirmDismiss: (_direction) {
        return showDialog(
          context: context,
          builder: (crx) => AlertDialog(
            title: const Text('are you sure?'),
            content: const Text('this action can not be reverse!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(crx, false);
                  },
                  child: const Text('NO')),
              TextButton(
                child: const Text('YES'),
                onPressed: () {
                  Navigator.pop(crx, true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
