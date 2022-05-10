import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_products.dart';
import '../models/product.dart';

class SingleProductDetails extends StatelessWidget {
  String productId;
  SingleProductDetails(this.productId);
  @override
  Widget build(BuildContext context) {
    var productInst = Provider.of<ProviderProduct>(context, listen: false);
    final products = productInst.items;
    Product product = products.firstWhere(
      (element) => element.id == productId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [Container(child: Image.network(product.imageURL))],
      ),
    );
  }
}



// Product(
//     id: 'p2',
//     title: 'Trousers',
//     description: 'A nice pair of trousers.',
//     price: 59.99,
//     imageURL: