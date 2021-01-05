import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cartData.dart';
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 6,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\₹ ${cart.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blue[400],
                  ),
                  FlatButton(
                    onPressed: null,
                    child: Text('ORDER NOW'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.cartData.length,
                itemBuilder: (ctx, i) => CartItems(
                    cart.cartData.values.toList()[i].idCart,
                    cart.cartData.keys.toList()[i],
                    cart.cartData.values.toList()[i].price,
                    cart.cartData.values.toList()[i].quantity,
                    cart.cartData.values.toList()[i].title)),
          )
        ],
      ),
    );
  }
}
