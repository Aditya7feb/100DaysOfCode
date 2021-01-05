import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widget/appbarcolor.dart';
import '../provider/provider_dummy.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product_Detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<ProviderDummy>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        flexibleSpace: AppBarColor(),
      ),
    );
  }
}
