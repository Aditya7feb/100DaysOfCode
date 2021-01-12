import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/app_drawer.dart';
import '../widget/admin_grid_items.dart';
import '../provider/provider_dummy.dart';
import './admin_edit_screen.dart';
import '../widget/appbarcolor.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/UserProductsScreen';
  @override
  Widget build(BuildContext context) {
    final prodDetail = Provider.of<ProviderDummy>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarColor(),
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: prodDetail.providerDummy.length,
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              UserProductItem(
                prodDetail.providerDummy[i].id,
                prodDetail.providerDummy[i].title,
                prodDetail.providerDummy[i].imageURL,
              ),
              Divider(
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
