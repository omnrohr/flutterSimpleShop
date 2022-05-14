import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/provider_products.dart';

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

  bool _firstTimeRun = true;

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageURL': ''
  };

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_firstTimeRun) {
      final _toEditProduct = ModalRoute.of(context).settings.arguments;
      if (_toEditProduct != null) {
        _editedProduct = _toEditProduct;
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          // 'imageURL': _toEditProduct.imageURL,
          'imageURL': '',
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _firstTimeRun = true;
    super.didChangeDependencies();
  }

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

  Future<void> _saveData() async {
    final isValid = _formGlobalKey.currentState.validate();
    if (!isValid) return;
    _formGlobalKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<ProviderProduct>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<ProviderProduct>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Sorry: something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          // setState(() {
                          //   _isLoading = false;
                          // });
                          // Navigator.pop(context);
                          // this code replace by adding <Null> type to showDialog.
                          // with that the resolving throw error will be ok btn and then method will continue execution
                        },
                        child: const Text('OK'))
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  bool validateInputs(String value, bool isNumber) {
    if (value.isEmpty) {
      return false;
    } else if (isNumber && double.tryParse(value) <= 0) {
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formGlobalKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: const InputDecoration(
                          label: Text('Product title:'),
                        ),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
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
                        initialValue: _initValues['price'],
                        decoration: const InputDecoration(
                          label: Text('Price:'),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        // focusNode: _priceFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
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
                        initialValue: _initValues['description'],
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
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
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
                                    child:
                                        Image.network(_imageUrlController.text),
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              // initialValue: _initValues['imageURL'], we are using controller and we can not use controller and initialValue together.
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
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    imageURL: value,
                                    description: _editedProduct.description);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide an image link';
                                }
                                return null;
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
