import 'package:flutter/material.dart';
import '../models/product.dart';
import '../pages/single_product_details.dart';

class SingleProductView extends StatelessWidget {
  final Product product;

  SingleProductView(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {},
          ),
          backgroundColor: Colors.grey,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((_) {
                  return SingleProductDetails(product);
                }),
              ),
            );
          },
          child: Image.network(
            product.imageURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
