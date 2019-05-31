import 'package:scoped_model/scoped_model.dart';

//models
import '../models/product.dart';

//scoped parent
import './connected_product.dart';


//class ProductModel extends ConnectedProducts 
mixin ProductModel on ConnectedProducts {
  bool _showFavorites = false;

  //GETTERS
  List<Product> get allProducts {
    //to not return a pointer to the same
    //object in memory (a new List)
    //this avoid the model.products.add(new Product(...))
    return List.from(products);
  }

  List<Product> get displayedProducts {
    //A list with all favorites products
    //the where method returns a new List by default
    //so we dont have to instance a new List Object
    if (_showFavorites) {
      return products.where((Product item) => item.isFavorite).toList();
    }
    return List.from(products);
  }

  Product get selectedProduct {
    if (selProductIndex == null) {
      return null;
    }
    return products[selProductIndex];
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  //SETTERS
  //--

  //METHODS
  // void addProduct(Product product) {
  //   _products.add(product);
  //   _selectedProductIndex = null;
  //   notifyListeners();
  // }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);

    products[selProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;

    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus);

    products[selProductIndex] = updatedProduct;

    /* Note: About Notify Listeners
       ----------------------------
       We call this function which is provided by 
       the scope model package, which will essentialy
       update all scope's model listeners, so they will
       re-render the ScopeModelDescendant Widget and all
       it's wrapped content.
    */

    notifyListeners();
    selProductIndex = null;
  }
}
