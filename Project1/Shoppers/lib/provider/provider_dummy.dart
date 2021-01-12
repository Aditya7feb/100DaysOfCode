import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './dummyData.dart';

class ProviderDummy with ChangeNotifier {
  List<DummyData> _providerDummy = [
    DummyData(
      id: 'p1',
      title: 'T-Shirt',
      description: 'A Adventure Ready T-Shirt from the house of woodland',
      imageURL:
          'https://images-na.ssl-images-amazon.com/images/I/91SZ3aDkLEL._UX679_.jpg',
      price: 650,
    ),
    DummyData(
      id: 'p2',
      title: 'Shoe',
      description: 'Go Outdoor with our new range of shoes',
      imageURL:
          'https://images-na.ssl-images-amazon.com/images/I/61utX8kBDlL._UL1100_.jpg',
      price: 3467,
    ),
    DummyData(
      id: 'p3',
      title: 'Watch',
      description: 'A premium range of exotic watches from the hosue of Titan',
      imageURL:
          'https://images-na.ssl-images-amazon.com/images/I/81xD5CXClhL._UL1500_.jpg',
      price: 12899,
    ),
    DummyData(
      id: 'p4',
      title: 'Wallet',
      description:
          'All new anti rfid wallet which protects you from many potential threats',
      imageURL:
          'https://images-na.ssl-images-amazon.com/images/I/7198j7fHuoL._SL1500_.jpg',
      price: 340,
    ),
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

  void addProducts(DummyData product) {
    final newProduct = DummyData(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      imageURL: product.imageURL,
      price: product.price,
    );
    _providerDummy.add(newProduct);
    notifyListeners();
  }

  void updateProducts(String id, DummyData newProduct) {
    final prodIndex = _providerDummy.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _providerDummy[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProducts(String id) {
    _providerDummy.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
