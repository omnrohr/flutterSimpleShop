import 'package:flutter/material.dart';

import '../models/product.dart';

class AddingEditingProductView extends StatefulWidget {
  static const addingEditingProductURL = '/add-edit-product';
  @override
  State<AddingEditingProductView> createState() =>
      _AddingEditingProductViewState();
}

class _AddingEditingProductViewState extends State<AddingEditingProductView> {
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageURL: '');

  @override
  void initState() {
    _imageFocusNode.removeListener(_imagePreview);
    _imageFocusNode.addListener(_imagePreview);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _imagePreview() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveData() {
    final isValid = _formGlobalKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formGlobalKey.currentState.save();
  }

  bool validateInputs(String value, bool isNumber) {
    if (value.isEmpty) {
      return false;
    } else if (isNumber && double.parse(value) > 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        actions: [
          IconButton(
            onPressed: _saveData,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formGlobalKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Product title:'),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: null,
                        title: value,
                        price: _editedProduct.price,
                        imageURL: _editedProduct.imageURL,
                        description: _editedProduct.description);
                  },
                  validator: (value) {
                    if (!validateInputs(value, false)) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Price:'),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // focusNode: _priceFocusNode,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: null,
                        title: _editedProduct.title,
                        price: double.parse(value),
                        imageURL: _editedProduct.imageURL,
                        description: _editedProduct.description);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please add a price';
                    } else if (double.parse(value) <= 0) {
                      return 'Price can not be 0 or less';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    label: Text('Description:'),
                  ),
                  keyboardType: TextInputType.multiline,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  // },
                  // focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: null,
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        imageURL: _editedProduct.imageURL,
                        description: value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please add some description';
                    } else if (value.length < 15) {
                      return 'Please add a descriptive description';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter a url to preview')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.contain,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Image URL'),
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        focusNode: _imageFocusNode,
                        onFieldSubmitted: (_value) {
                          _saveData();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: null,
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              imageURL: value,
                              description: _editedProduct.description);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide an image link';
                          }
                        },
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
