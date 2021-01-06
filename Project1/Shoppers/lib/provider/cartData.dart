import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String idCart;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.idCart,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartData = {};

  Map<String, CartItem> get cartData {
    return {..._cartData};
  }

  int get itemCount {
    return cartData.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartData.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItems(String productId, double price, String title) {
    notifyListeners();
    if (_cartData.containsKey(productId)) {
      _cartData.update(
        productId,
        (existing) => CartItem(
          idCart: existing.idCart,
          title: existing.title,
          quantity: existing.quantity + 1,
          price: existing.price,
        ),
      );
    } else {
      _cartData.putIfAbsent(
        productId,
        () => CartItem(
            idCart: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
  }

  void removeItem(String id) {
    _cartData.remove(id);
    notifyListeners();
  }

  void clear() {
    _cartData = {};
    notifyListeners();
  }
}
