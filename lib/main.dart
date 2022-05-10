import 'package:flutter/material.dart';
import '../providers/provider_products.dart';
import 'package:provider/provider.dart';

import './pages/products_overview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderProduct(),
      // value: ProviderProduct(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            headline6: TextStyle(
                fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        home: ProductsOverview(),
      ),
    );
  }
}
