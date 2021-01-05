import 'package:flutter/foundation.dart';

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

  void setFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
