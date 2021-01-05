import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/provider_dummy.dart';

import 'grid_Items.dart';

class GridBox extends StatelessWidget {
  final bool showFav;

  GridBox(this.showFav);

  @override
  Widget build(BuildContext context) {
    final dummyData = Provider.of<ProviderDummy>(context);
    final loadedProducts =
        showFav ? dummyData.favourites : dummyData.providerDummy;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (context) => loadedProducts[i],
        value: loadedProducts[i],
        child: GridItem(),
      ),
    );
  }
}
