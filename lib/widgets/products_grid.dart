import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_products.dart';
import '../widgets/single_product_view.dart';

class ProductsGrid extends StatelessWidget {
  bool isOnlyFavorite;
  ProductsGrid(this.isOnlyFavorite);
  @override
  Widget build(BuildContext context) {
    final productInst = Provider.of<ProviderProduct>(context);
    final products =
        isOnlyFavorite ? productInst.favoriteItems : productInst.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        child: SingleProductView(),
        // create: (context) => products[i],
        value: products[i],
      ),
    );
  }
}
