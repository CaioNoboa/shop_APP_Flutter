import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid({
    Key? key,
    required this.showFavoriteOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      // itemBuilder define como será construído cada elemento da grid view
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          // create: (_) => loadedProducts[index], // como ChangeNotifierProvider já está criado usaremos value
          value: loadedProducts[index],
          child: ProductItem(),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // mostrará 2 produtos por linha
        childAspectRatio: 3 / 2, // qual a relação entre largura e altura
        mainAxisSpacing: 10, // espaçamento no eixo principal
        crossAxisSpacing: 10, // espaçamento no eixo cruzado
      ),
    );
  }
}
