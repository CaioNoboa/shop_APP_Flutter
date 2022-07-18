import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    // o padrão é listen: true, para que este componente esteja 'escutando' as mudanças de estado. Ao colocarmos false, podemos usar o Consumer apenas na parte do código que a interface será alterada pela mudança de estado. Assim, otimizamos a aplicação, pois os componentes que não sofrerão alteração na interface não serão renderizados novamente.

    return ClipRRect(
      // corta de forma arredondada determinado elemento
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productDetail,
              arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context1, product, _) => IconButton(
              // coloquei context1 para usar o contexto lá do main. Se colocar apenas context, a cor do ícone será alterada, pois utilizará o BuildContext desse arquivo
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
