import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products_grid.dart';

final List<Product> products = [];

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: ProductsGrid(),
    );
  }
}
