import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/product_Detail.dart';
import './screen/homepage.dart';
import './provider/provider_dummy.dart';
import './provider/cartData.dart';
import './Screen/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProviderDummy(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
        home: Homepage(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
