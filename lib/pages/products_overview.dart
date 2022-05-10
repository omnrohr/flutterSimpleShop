import 'package:flutter/material.dart';
import 'package:myapp/providers/provider_products.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/products_grid.dart';

enum Filters { Favorites, All }

final List<Product> products = [];

class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _onlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only favorites'),
                value: Filters.Favorites,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: Filters.All,
              )
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              setState(() {
                if (value == Filters.Favorites) {
                  _onlyFavorites = true;
                } else {
                  _onlyFavorites = false;
                }
              });
            },
          )
        ],
        title: Text('My Shop'),
      ),
      body: ProductsGrid(_onlyFavorites),
    );
  }
}
