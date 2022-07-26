import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-cod3r-5ef24-default-rtdb.firebaseio.com';
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }
  // colocamos entre [...] para que seja exibido uma cópia da lista. Assim, para alterações dessa lista será necessário utilizar os métodos dessa classe.

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    // se é diferente de nulo, temos Id

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) {
    final future = http
        .post(
      Uri.parse('$_baseUrl/products.json'), // .json é requerido pelo firebase
      body: jsonEncode(
        {
          'name': product.name,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );
    return future.then<void>((response) {
      final id = jsonDecode(response.body)['name'];
      _items.add(Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ));
      notifyListeners();
      // alterações precisam do notifyListeners para que o ChangeNotifier cumpra seu papel no padrão Observer.
    });
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      // produto válido
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == product.id);
      notifyListeners();
    }
  }
}
