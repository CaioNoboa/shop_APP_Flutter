import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((product) => product.isFavorite).toList();
    }
    return [..._items];
  }
  // colocamos entre [...] para que seja exibido uma cópia da lista. Assim, para alterações dessa lista será necessário utilizar os métodos dessa classe.

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
    // alterações precisam do notifyListeners para que o ChangeNotifier cumpra seu papel no padrão Observer.
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }
}
