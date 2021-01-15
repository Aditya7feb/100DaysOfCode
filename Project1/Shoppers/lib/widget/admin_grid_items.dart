import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/admin_edit_screen.dart';
import '../provider/provider_dummy.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  UserProductItem(this.id, this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Colors.green,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<ProviderDummy>(context, listen: false)
                      .deleteProducts(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(content: Text('Could not delete item')),
                  );
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
