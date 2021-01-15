import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exceptions.dart';

import './dummyData.dart';

class ProviderDummy with ChangeNotifier {
  List<DummyData> _providerDummy = [
    // DummyData(
    //   id: 'p1',
    //   title: 'T-Shirt',
    //   description: 'A Adventure Ready T-Shirt from the house of woodland',
    //   imageURL:
    //       'https://images-na.ssl-images-amazon.com/images/I/91SZ3aDkLEL._UX679_.jpg',
    //   price: 650,
    // ),
    // DummyData(
    //   id: 'p2',
    //   title: 'Shoe',
    //   description: 'Go Outdoor with our new range of shoes',
    //   imageURL:
    //       'https://images-na.ssl-images-amazon.com/images/I/61utX8kBDlL._UL1100_.jpg',
    //   price: 3467,
    // ),
    // DummyData(
    //   id: 'p3',
    //   title: 'Watch',
    //   description: 'A premium range of exotic watches from the hosue of Titan',
    //   imageURL:
    //       'https://images-na.ssl-images-amazon.com/images/I/81xD5CXClhL._UL1500_.jpg',
    //   price: 12899,
    // ),
    // DummyData(
    //   id: 'p4',
    //   title: 'Wallet',
    //   description:
    //       'All new anti rfid wallet which protects you from many potential threats',
    //   imageURL:
    //       'https://images-na.ssl-images-amazon.com/images/I/7198j7fHuoL._SL1500_.jpg',
    //   price: 340,
    // ),
  ];

  //var _showFavourites = false;

  List<DummyData> get providerDummy {
    // if (_showFavourites == true) {
    //   return _providerDummy.where((prodItem) => prodItem.isFavourite).toList();
    // }
    return [..._providerDummy];
  }

  List<DummyData> get favourites {
    return _providerDummy.where((prodItem) => prodItem.isFavourite).toList();
  }

  DummyData findById(String id) {
    return _providerDummy.firstWhere((product) => product.id == id);
  }

  // void showFavouritesOnly() {
  //   _showFavourites = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavourites = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<DummyData> loadedProducts = [];
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(
          DummyData(
            id: prodID,
            title: prodData['title'],
            description: prodData['description'],
            imageURL: prodData['url'],
            price: prodData['price'],
            isFavourite: prodData['isfavourite'],
          ),
        );
      });
      _providerDummy = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProducts(DummyData product) async {
    const url =
        'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'isfavourite': product.isFavourite,
          'url': product.imageURL,
        }),
      );
      print(json.decode(response.body));
      final newProduct = DummyData(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageURL: product.imageURL,
        price: product.price,
      );
      _providerDummy.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProducts(String id, DummyData newProduct) async {
    final prodIndex = _providerDummy.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'isfavourite': newProduct.isFavourite,
            'url': newProduct.imageURL,
          }));
      _providerDummy[prodIndex] = newProduct;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> deleteProducts(String id) async {
    final url =
        'https://flutter-shop-a75c3-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _providerDummy.indexWhere((element) => element.id == id);
    var existingProducts = _providerDummy[existingProductIndex];
    _providerDummy.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _providerDummy.insert(existingProductIndex, existingProducts);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existingProducts = null;
  }
}
