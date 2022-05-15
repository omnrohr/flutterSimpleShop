import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  static const _apiKey = 'AIzaSyCEalQEcHqsVrehi-zpnl13AWhD97-rt1I';
  static const _loginUrl = 'signInWithPassword';
  static const _signUpUrl = 'signUp';
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(String email, String password, String type) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$type?key=$_apiKey');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, _signUpUrl);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, _loginUrl);
  }

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String get userId {
    return _userId;
  }
}
