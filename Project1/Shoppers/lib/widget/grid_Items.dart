import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/product_Detail.dart';
import '../provider/dummyData.dart';
import '../provider/cartData.dart';

class GridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<DummyData>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetail.routeName,
                arguments: loadedProduct.id);
          },
          child: Image.network(
            loadedProduct.imageURL,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            loadedProduct.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,

          //note for using the Consumer<>()builder:(ctx,dyn,child)

          //label : child
          //child: Text('abc');
          //we chan ignore child by using a underscore _ on place of child

          //here the child part doesn't rebuilds when the consumer generelly rebuilds

          //consumer is as same as Provider.of(context) but it gives the ability
          //to mark a specific part of widget to rebuild whenever the data
          //changes instead of the whole widget...
          //using it in the same way i have used below

          //here when we mark the product as favourite the only the favourite
          //icon is re-built not the whole grid tile

          leading: Consumer<DummyData>(
            builder: (context, loadedProduct, child) => IconButton(
              icon: Icon(loadedProduct.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_outline),
              onPressed: () {
                loadedProduct.setFavourite();
              },
              color: Colors.red,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItems(
                  loadedProduct.id, loadedProduct.price, loadedProduct.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Product Added to Cart.!"),
                  duration: Duration(seconds: 1, milliseconds: 50),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.yellow,
                    onPressed: () {
                      cart.removeSingleItem(loadedProduct.id);
                    },
                  ),
                ),
              );
            },
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
