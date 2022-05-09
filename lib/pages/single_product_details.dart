import 'package:flutter/material.dart';

import '../models/product.dart';

class SingleProductDetails extends StatelessWidget {
  final Product product;
  SingleProductDetails(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Container(
            child: Image.network(product.imageURL),
          )
        ],
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