import 'package:scoped_model/scoped_model.dart';

//models
import '../models/product.dart';
import '../models/user.dart';

//class ConnectedProducts extends Model {
mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticated;

  int _selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticated.email,
        userId: _authenticated.id);

    _products.add(newProduct);
    _selProductIndex = null;
    notifyListeners();
  }
}

//PRODUCT

mixin ProductModel on ConnectedProductsModel {
  bool _showFavorites = false;

  //GETTERS
  List<Product> get allProducts {
    //to not return a pointer to the same
    //object in memory (a new List)
    //this avoid the model._products.add(new Product(...))
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    //A list with all favorites _products
    //the where method returns a new List by default
    //so we dont have to instance a new List Object
    if (_showFavorites) {
      return _products.where((Product item) => item.isFavorite).toList();
    }
    return List.from(_products);
  }

  Product get selectedProduct {
    if (_selProductIndex == null) {
      return null;
    }
    return _products[_selProductIndex];
  }

  int get selectedProductIndex {
    return _selProductIndex;
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
    _products.removeAt(_selProductIndex);
    _selProductIndex = null;
    notifyListeners();
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);

    _products[_selProductIndex] = updatedProduct;
    _selProductIndex = null;
    //notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
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

    _products[_selProductIndex] = updatedProduct;

    /* Note: About Notify Listeners
       ----------------------------
       We call this function which is provided by 
       the scope model package, which will essentialy
       update all scope's model listeners, so they will
       re-render the ScopeModelDescendant Widget and all
       it's wrapped content.
    */

    notifyListeners();
    _selProductIndex = null;
  }
}

//USERS

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticated =
        User(id: 'ee8aldk-20019a-fff82711', email: email, password: password);
    print('logeando dentro de la clase...');
    print('email:' + _authenticated.email.toString());
    print('password:' + _authenticated.password.toString());
  }
}
