import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/adding_editing_product_view.dart';
import '../providers/provider_products.dart';
import '../models/product.dart';

class UserProductWidget extends StatelessWidget {
  final Product product;
  UserProductWidget(this.product);
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, AddingEditingProductView.addingEditingProductURL,
                  arguments: product);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              try {
                await Provider.of<ProviderProduct>(context, listen: false)
                    .deleteProduct(product.id);
              } catch (e) {
                scaffold.showSnackBar(
                    SnackBar(content: Text('item can not be deleted $e')));
                rethrow;
              }
            },
            icon: const Icon(Icons.delete),
          )
        ]),
      ),
    );
  }
}
