import 'package:flutter/material.dart';
import 'package:myapp/providers/provider_products.dart';
import 'package:provider/provider.dart';
import '../pages/adding_editing_product_view.dart';

import '../models/product.dart';

class UserProductWidget extends StatelessWidget {
  final Product product;
  UserProductWidget(this.product);
  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ProviderProduct>(context, listen: false)
                  .deleteProduct(product.id);
            },
            icon: Icon(Icons.delete),
          )
        ]),
      ),
    );
  }
}
