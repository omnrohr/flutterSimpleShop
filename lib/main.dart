import 'package:flutter/material.dart';
import 'package:myapp/pages/orders_view.dart';
import '../providers/provider_products.dart';
import 'package:provider/provider.dart';

import './pages/products_overview.dart';
import './pages/cart.dart';
import './models/cart.dart';
import './models/order.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderProduct(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        // value: ProviderProduct(),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            headline6: TextStyle(
                fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        home: ProductsOverview(),
        routes: {
          ProductsOverview.productsOverviewRout: (context) =>
              ProductsOverview(),
          CartView.cartRout: (context) => CartView(),
          Orders.ordersRout: (context) => OrdersView(),
        },
      ),
    );
  }
}
