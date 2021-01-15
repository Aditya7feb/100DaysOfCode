import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart' show Orders;
import '../widget/order_item.dart';
import '../widget/app_drawer.dart';
import '../widget/appbarcolor.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    });
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: AppBarColor(),
          title: Text(
            'Your Orders',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) {
                  return OrderItem(orderData.orders[i]);
                },
              ));
  }
}
