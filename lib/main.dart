import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_products.dart';
import './pages/products_overview.dart';
import './pages/cart.dart';
import './models/cart.dart';
import './models/order.dart';
import './pages/orders_view.dart';
import './pages/user_products_view.dart';
import './pages/adding_editing_product_view.dart';
import './pages/auth_view.dart';
import './models/auth.dart';
import './pages/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProviderProduct>(
          update: (ctx, auth, previusProducts) => ProviderProduct(
              auth.token,
              auth.userId,
              previusProducts == null ? [] : previusProducts.items),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, prevItems) => Orders(auth.token, auth.userId,
                prevItems == null ? [] : prevItems.orderItems)),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        // value: ProviderProduct(),
      ],
      child: Consumer<Auth>(
        builder: (ctx, userData, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            textTheme: const TextTheme(
              headline6: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          home: userData.isAuthenticated
              ? ProductsOverview()
              : FutureBuilder(
                  future: userData.tryAutoLogIn(),
                  builder: (ctx, authResultSnapshots) =>
                      authResultSnapshots.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductsOverview.productsOverviewRout: (context) =>
                ProductsOverview(),
            CartView.cartRout: (context) => CartView(),
            Orders.ordersRout: (context) => OrdersView(),
            UserProductsView.userProductURL: (context) => UserProductsView(),
            AddingEditingProductView.addingEditingProductURL: (context) =>
                AddingEditingProductView(),
            AuthScreen.authRouteName: (context) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
