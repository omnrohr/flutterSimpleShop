import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/http_exception.dart';

import '../models/product.dart';

class ProviderProduct with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageURL:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  final String authToken;
  final String userId;
  ProviderProduct(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [
      ..._items
    ]; //  return a copy of item not the main list , revisit the lecture to know https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15100258#questions
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://shopapp-b795e-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageURL': product.imageURL,
            'ownerId': userId,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageURL: product.imageURL);
      _items.add(newProduct);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final lookUpItem = _items.indexWhere((element) => element.id == id);
    if (lookUpItem >= 0) {
      final url = Uri.parse(
          'https://shopapp-b795e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'price': newProduct.price,
            'imageURL': newProduct.imageURL,
            'description': newProduct.description
          },
        ),
      );
      _items[lookUpItem] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shopapp-b795e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProductPointer = _items[existingProductIndex];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProductPointer);
      notifyListeners();
      throw HttpException('Invalid url');
    }
    existingProductPointer = null;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final _params = filterByUser
        ? {
            'auth': authToken,
            'orderBy': '"ownerId"',
            'equalTo': '"$userId"',
          }
        : {
            'auth': authToken,
          };

    // var url = Uri.parse(
    //     'https://shopapp-b795e-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="ownerId"&equalTo"$userId"');
    var url = Uri.https(
        'shopapp-b795e-default-rtdb.firebaseio.com', '/products.json', _params);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {});
      List<Product> receivedProducts = [];
      if (extractedData == null) return;
      url = Uri.parse(
          'https://shopapp-b795e-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);

      final favoriteData =
          json.decode(favoriteResponse.body) as Map<String, dynamic>;

      extractedData.forEach((productId, value) {
        receivedProducts.add(
          Product(
              id: productId,
              description: value['description'],
              imageURL: value['imageURL'],
              price: value['price'],
              title: value['title'],
              isFavorite: favoriteData == null
                  ? false
                  : favoriteData[productId] ?? false),
        );

        _items = receivedProducts;
        notifyListeners();
      });
    } catch (err) {
      rethrow;
    }
  }
}
