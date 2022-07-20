import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      // todo classe with ChangeNotifier precisa ser passada acima
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.home: (context) => ProductsOverviewPage(),
          AppRoutes.productDetail: (context) => ProductDetailPage(),
          AppRoutes.cart: (context) => CartPage(),
          AppRoutes.orders: (context) => OrdersPage(),
          AppRoutes.products: (context) => ProductsPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
