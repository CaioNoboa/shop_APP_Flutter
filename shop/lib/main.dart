import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/theme.dart';
import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        // O ProductList precisa do token que está em Auth, para isso colocamos o ChangeNotifierProvider de Auth antes do ProductList e alteramos o código abaixo:
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (context, auth, previous) {
            return ProductList(auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (context, auth, previous) {
            return OrderList(auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      // todo classe with ChangeNotifier precisa ser passada acima
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.authOrHome: (context) => AuthOrHomePage(),
          AppRoutes.productDetail: (context) => ProductDetailPage(),
          AppRoutes.cart: (context) => CartPage(),
          AppRoutes.orders: (context) => OrdersPage(),
          AppRoutes.products: (context) => ProductsPage(),
          AppRoutes.productForm: (context) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
