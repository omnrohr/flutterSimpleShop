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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Product title:'),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Price:'),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // focusNode: _priceFocusNode,
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
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Image link:'),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
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
                          ? const Text('enter url to preview')
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
