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
        // appBar: AppBar(
        //   title: Text(product.title),
        // ),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              product.title,
            ),
            background: Hero(
              tag: product.id,
              child: Image.network(
                product.imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${product.price}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${product.title}',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 800,
              )
            ],
          ),
        ])),
      ],
    ));
  }
}



// Product(
//     id: 'p2',
//     title: 'Trousers',
//     description: 'A nice pair of trousers.',
//     price: 59.99,
//     imageURL: