import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: ProductsOverviewPage(),
      routes: {
        AppRoutes.productDetail: (context) => ProductDetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
