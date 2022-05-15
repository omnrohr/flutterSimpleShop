import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final id;
  final title;
  final description;
  final price;
  final imageURL;
  bool isFavorite;

  void _rollbackFavorites(bool oldFavorite) {
    isFavorite = oldFavorite;
    notifyListeners();
  }

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageURL,
      this.isFavorite = false});

  Future<void> toggleFavorite(String authToken, String userId) async {
    final oldFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://shopapp-b795e-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken');
    // http
    //     .patch(url,
    //         body: json.encode({
    //           'isFavorite': isFavorite,
    //         }))
    //     .catchError((e) {
    //   throw e;
    // }).then((value) {
    //   if (value.statusCode >= 400) {
    //     isFavorite = oldFavorate;
    //     notifyListeners();
    //     throw Exception('Sorry not completed!');
    //   }
    // });

    // or use this method with async and await;

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        // _rollbackFavorites(oldFavorite);
        // it will fire the function from catch.
        throw Exception('error in server!');
      }
    } catch (e) {
      _rollbackFavorites(oldFavorite);
      rethrow;
    }
  }
}
