import 'package:flutter/material.dart';

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
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          )
        ]),
      ),
    );
  }
}
