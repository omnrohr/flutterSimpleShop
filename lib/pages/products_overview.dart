import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/cart.dart';
import '../widgets/app_drawer.dart';
import '../models/product.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../models/cart.dart';

enum Filters { Favorites, All }

final List<Product> products = [];

class ProductsOverview extends StatefulWidget {
  static const productsOverviewRout = '/products';
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _onlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // var cart = Provider.of<Cart>(context); with this approach it will build all screen so better approach is
    // to call consumers at the widget which interested.
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
          ),
          Consumer<Cart>(
            builder: (context, cart, passedChild) => Badge(
              value: cart.count.toString(),
              child: passedChild,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.pushNamed(context, CartView.cartRout);
              },
            ),
          ),
        ],
        title: Text('My Shop'),
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_onlyFavorites),
    );
  }
}
