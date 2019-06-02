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
  String _selProductId;
  bool _isLoading = false;
  //fetch prop
  String _productsUrl =
      'https://flutter-course-fe6e4.firebaseio.com/products.json';
}

//PRODUCT

mixin ProductModel on ConnectedProductsModel {
  bool _showFavorites = false;

  //----------------------------
  //          GETTERS
  //----------------------------

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
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  //----------------------------
  //          METHODS
  //----------------------------

  Future<bool> fetchProducts() {
    _isLoading = true;
    notifyListeners();

    return http.get(_productsUrl).then<Null>((http.Response response) {
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
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> addProduct(
      String title, String description, String image, double price) async {
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

    try {
      final http.Response response =
          await http.post(_productsUrl, body: json.encode(productData));

      final int statusCode = response.statusCode;

      if (statusCode != 200 && statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticated.email,
          userId: _authenticated.id);

      _products.add(newProduct);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      //print(error);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(
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

      _products[selectedProductIndex] = updatedProduct;
      //_selProductIndex = null;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });

    ///
  }

  Future<bool> deleteProduct() {
    String deleteUrl =
        'https://flutter-course-fe6e4.firebaseio.com/products/${selectedProduct.id}.json';
    final deletedProductId = selectedProduct.id;

    _isLoading = true;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();

    return http.delete(deleteUrl).then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  //----------------------------
  //          HELPERS
  //----------------------------

  void selectProduct(String productId) {
    _selProductId = productId;
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
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus);

    _products[selectedProductIndex] = updatedProduct;

    /* Note: About Notify Listeners
       ----------------------------
       We call this function which is provided by 
       the scope model package, which will essentialy
       update all scope's model listeners, so they will
       re-render the ScopeModelDescendant Widget and all
       it's wrapped content.
    */

    notifyListeners();
    _selProductId = null;
  }
}

//USERS

mixin UserModel on ConnectedProductsModel {
  final String _apiToken = 'AIzaSyB3yMiTBCqFs-5Sfq1zYyryFpSO50mfrAI';

  //---------------------------------
  //      AUTHENTICATION METHODS
  //---------------------------------

  //SIGN IN
  Future<Map<String, dynamic>> login(String email, String password) async {
    String signInUrl =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_apiToken';

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    bool success = false;
    String message = 'Something went wrong!';

    print('Sign In...');

    final http.Response response = await http.post(signInUrl,
        headers: {'Content-type': 'application/json'},
        body: json.encode(authData));

    final Map<String, dynamic> responseData = json.decode(response.body);


    if (responseData.containsKey('idToken')) {
      success = true;
      message = 'Authentication succeeded!';
    } else {
      switch (responseData['error']['message']) {
        case 'EMAIL_NOT_FOUND':
          message = 'This email was not found.';
          break;
        case 'INVALID_PASSWORD':
          message = 'The password is invalid.';
          break;
        case 'USER_DISABLED':
          message = 'The user account has been disabled by an administrator.';
          break;
      }
    }
    _isLoading = false;
    notifyListeners();

    return {'success': success, 'message': message};
  }

  //SIGNUP
  Future<Map<String, dynamic>> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    String signUpUrl =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_apiToken';

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    bool success = false;
    String message = 'Something went wrong!';

    print('Sign Up...');

    final http.Response response = await http.post(signUpUrl,
        headers: {'Content-type': 'application/json'},
        body: json.encode(authData));

    final Map<String, dynamic> responseData = json.decode(response.body);

    //print('Response from firebase.. ' + responseData.toString());

    if (responseData.containsKey('idToken')) {
      success = true;
      message = 'Authentication succeeded!';
    } else {

      switch (responseData['error']['message']) {
        case 'EMAIL_EXISTS':
          message = 'This email already exists';
          break;
        case 'OPERATION_NOT_ALLOWED':
          message = 'Password sign-in is disabled. Try again later.';
          break;
        case 'TOO_MANY_ATTEMPTS_TRY_LATER':
          message =
              'We have blocked all requests from this device due to unusual activity. Try again later.';
          break;
        case 'WEAK_PASSWORD':
          message = 'Password should be at least 6 characters';
          break;
      }
    }

    _isLoading = false;
    notifyListeners();

    return {'success': success, 'message': message};
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
