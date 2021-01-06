import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/appbarcolor.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageURL,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\₹${loadedProduct.price}",
              style: TextStyle(color: Colors.grey[700], fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Description: \n${loadedProduct.description}",
                style: TextStyle(color: Colors.grey[700], fontSize: 18),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
