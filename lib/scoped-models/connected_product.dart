import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

//models
import '../models/product.dart';
import '../models/user.dart';

//class ConnectedProducts extends Model {
mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticated;
  int _selProductIndex;
  bool _isLoading = false;
  //fetch prop
  String _productsUrl =
      'https://flutter-course-fe6e4.firebaseio.com/products.json';

  Future<Null> addProduct(
      String title, String description, String image, double price) {
    //Product newProduct;
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'http://as01.epimg.net/deporteyvida/imagenes/2018/05/07/portada/1525714597_852564_1525714718_noticia_normal.jpg',
      'price': price,
      'userEmail': _authenticated.email,
      'userId': _authenticated.id,
    };

    //print('sending request to firebase...');
    return http
        .post(_productsUrl, body: json.encode(productData))
        .then((http.Response response) {
      _isLoading = false;
      //notifyListeners();
      final Map<String, dynamic> responseData = json.decode(response.body);
      //print(responseData);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticated.email,
          userId: _authenticated.id);
      _products.add(newProduct);
      _selProductIndex = null;
      notifyListeners();
    });
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

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http.get(_productsUrl).then((http.Response response) {
      _isLoading = false;
      final List<Product> fetchProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);

      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            userEmail: productData['userEmail'],
            userId: productData['userId'].toString(),
            price: productData['price']);

        fetchProductList.add(product);
      });

      _products = fetchProductList;
      _isLoading = false;
      notifyListeners();
    }); //end then
  }

  void deleteProduct() {
    String deleteUrl =
        'https://flutter-course-fe6e4.firebaseio.com/products/${selectedProduct.id}.json';
    final deletedProductId = selectedProduct.id;

    _isLoading = true;
    _products.removeAt(_selProductIndex);
    _selProductIndex = null;
    notifyListeners();

    http.delete(deleteUrl).then((http.Response response){
      _isLoading=false;
      notifyListeners();
    });
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    String updateUrl =
        'https://flutter-course-fe6e4.firebaseio.com/products/${selectedProduct.id}.json';

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'http://as01.epimg.net/deporteyvida/imagenes/2018/05/07/portada/1525714597_852564_1525714718_noticia_normal.jpg',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };

    return http
        .put(updateUrl, body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      final Product updatedProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);

      _products[_selProductIndex] = updatedProduct;
      _selProductIndex = null;
      notifyListeners();
    });

    ///
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
    //print('logeando dentro de la clase...');
    //print('email:' + _authenticated.email.toString());
    //print('password:' + _authenticated.password.toString());
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
