import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../pages/single_product_details.dart';

class SingleProductView extends StatelessWidget {
  // final Product product;

  // SingleProductView(this.product);

  @override
  Widget build(BuildContext context) {
    final providerProduct = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(providerProduct.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              providerProduct.toggleFavorite();
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {},
          ),
          backgroundColor: Colors.grey,
          title: Text(
            providerProduct.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((_) {
                  return SingleProductDetails(providerProduct.id);
                }),
              ),
            );
          },
          child: Image.network(
            providerProduct.imageURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}