import 'package:flutter/material.dart';
import './cartData.dart';

class OrderItems {
  String id;
  double price;
  List<CartItem> products;
  DateTime dateTime;

  OrderItems({
    this.id,
    this.price,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItems(
        id: DateTime.now().toString(),
        dateTime: DateTime.now(),
        price: total,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
