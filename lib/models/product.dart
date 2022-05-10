import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final id;
  final title;
  final description;
  final price;
  final imageURL;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageURL,
      this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
