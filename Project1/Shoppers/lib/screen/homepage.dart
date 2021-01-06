import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/grid_box.dart';
import '../widget/appbarcolor.dart';
import '../widget/badge.dart';
import '../provider/cartData.dart';
import '../screen/cart_screen.dart';
import '../widget/app_drawer.dart';

enum Favstat {
  TrueFav,
  FalseFav,
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    //final contaonerOptions = Provider.of<ProviderDummy>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        flexibleSpace: AppBarColor(),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (Favstat selectedOption) {
              setState(() {
                if (selectedOption == Favstat.TrueFav) {
                  _showFavourites = true;
                  //contaonerOptions.showFavouritesOnly();
                } else {
                  _showFavourites = false;
                  //contaonerOptions.showAll();
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Show Favourites"),
                value: Favstat.TrueFav,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: Favstat.FalseFav,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: GridBox(_showFavourites),
    );
  }
}
