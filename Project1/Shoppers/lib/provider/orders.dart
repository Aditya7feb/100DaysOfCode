import 'dart:convert';
import 'package:flutter/material.dart';
import './cartData.dart';

import 'package:http/http.dart' as http;

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

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItems> loadedOrder = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      loadedOrder.add(OrderItems(
        id: orderID,
        price: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map(
              (cp) => CartItem(
                idCart: cp['id'],
                title: cp['title'],
                quantity: cp['quantity'],
                price: cp['price'],
              ),
            )
            .toList(),
      ));
    });
    _orders = loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.idCart,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );

    _orders.insert(
      0,
      OrderItems(
        id: json.decode(response.body)['name'],
        dateTime: timeStamp,
        price: total,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
