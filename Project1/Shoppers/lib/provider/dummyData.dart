import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DummyData with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageURL;
  bool isFavourite;

  DummyData({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageURL,
    @required this.price,
    this.isFavourite = false,
  });

  void _setFav(bool newVal) {
    isFavourite = newVal;
    notifyListeners();
  }

  Future<void> setFavourite() async {
    final url =
        'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/products/$id.json';
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isfavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFav(oldStatus);
      }
    } catch (error) {
      _setFav(oldStatus);
    }
  }
}
