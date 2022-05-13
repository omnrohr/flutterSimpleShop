import 'package:flutter/material.dart';
import 'package:myapp/pages/adding_editing_product_view.dart';
import 'package:provider/provider.dart';

import '../widgets/user_products_widget.dart';
import '../providers/provider_products.dart';
import '../widgets/app_drawer.dart';

class UserProductsView extends StatelessWidget {
  static const userProductURL = '/user-products';
  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<ProviderProduct>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final providedProducts = Provider.of<ProviderProduct>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, AddingEditingProductView.addingEditingProductURL);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (_ctx, i) => Column(children: [
              UserProductWidget(providedProducts.items[i]),
              Divider(),
            ]),
            itemCount: providedProducts.items.length,
          ),
        ),
      ),
    );
  }
}
