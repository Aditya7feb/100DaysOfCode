import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dummyData.dart';
import '../provider/provider_dummy.dart';
import '../widget/appbarcolor.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/Edit-Screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  var _editedProduct =
      DummyData(id: null, title: '', description: '', imageURL: '', price: 0);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  var _initValues = {
    'title': '',
    'description': '',
    'imageURL': '',
    'price': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        final product = Provider.of<ProviderDummy>(context, listen: false)
            .findById(productID);
        _editedProduct = product;

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          // 'imageURL': _editedProduct.imageURL,
          'price': _editedProduct.price.toString(),
          'imageURL': '',
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveProduct() {
    final isValidated = _form.currentState.validate();
    if (!isValidated) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<ProviderDummy>(context, listen: false)
          .updateProducts(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<ProviderDummy>(context, listen: false)
          .addProducts(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarColor(),
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveProduct();
              })
        ],
      ),
      body: Form(
          key: _form,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Value';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _editedProduct = DummyData(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: newValue,
                      description: _editedProduct.description,
                      imageURL: _editedProduct.imageURL,
                      price: _editedProduct.price,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    if (double.tryParse(value) == null) {
                      return "Please Enter a Valid Number";
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter a Number Greater than Zero';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _editedProduct = DummyData(
                        id: _editedProduct.id,
                        isFavourite: _editedProduct.isFavourite,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        imageURL: _editedProduct.imageURL,
                        price: double.parse(newValue));
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Description';
                    }
                    if (value.length <= 10) {
                      return 'Please Enter Description above 10 characters';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _editedProduct = DummyData(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: newValue,
                      imageURL: _editedProduct.imageURL,
                      price: _editedProduct.price,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Colors.grey,
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter Image URL')
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          // initialValue: _initValues['imageURL'],
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) {
                            [
                              setState(() {}),
                              _saveProduct(),
                            ];
                          },
                          focusNode: _imageUrlFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Value';
                            }
                            if (!value.startsWith('https')) {
                              return 'Please enter url starting with https://';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            _editedProduct = DummyData(
                              id: _editedProduct.id,
                              isFavourite: _editedProduct.isFavourite,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              imageURL: newValue,
                              price: _editedProduct.price,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
