import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFavorites = false;

  //GETTERS
  List<Product> get products {
    //to not return a pointer to the same
    //object in memory (a new List)
    //this avoid the model.products.add(new Product(...))
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    //A list with all favorites products
    //the where method returns a new List by default
    //so we dont have to instance a new List Object
    if (_showFavorites) {
      return _products.where((Product item)=>item.isFavorite).toList();
    }
    return List.from(_products);
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  bool get displayFavoritesOnly{
    return _showFavorites;
  }

  //SETTERS
  //--

  //METHODS
  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode(){
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
        isFavorite: newFavoriteStatus);

    updateProduct(updatedProduct);

    /* Note: About Notify Listeners
       ----------------------------
       We call this function which is provided by 
       the scope model package, which will essentialy
       update all scope's model listeners, so they will
       re-render the ScopeModelDescendant Widget and all
       it's wrapped content.
    */
    notifyListeners();
    _selectedProductIndex = null;
  }
}
