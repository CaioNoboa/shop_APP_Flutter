import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  List<Product> loadedProducts = dummyProducts;
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          // itemBuilder define como será construído cada elemento da grid view
          itemBuilder: (context, index) {
            return Text(loadedProducts[index].title);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // mostrará 2 produtos por linha
            childAspectRatio: 3 / 2, // qual a relação entre largura e altura
            mainAxisSpacing: 10, // espaçamento no eixo principal
            crossAxisSpacing: 10, // espaçamento no eixo cruzado
          ),
        ),
      ),
    );
  }
}
