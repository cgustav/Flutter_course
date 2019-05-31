import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  //GETTER
  List<Product> get products{
    //to not return a pointer to the same
    //object in memory (a new List)
    return List.from(_products);
  }

  int get selectedProductIndex{
    return _selectedProductIndex;
  }

  Product get selectedProduct{
    if(_selectedProductIndex ==  null){
      return null;
    }
    return _products[_selectedProductIndex];
  }
  //SETTER
  //--

  //METHODS
  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void selectProduct(int index){
    _selectedProductIndex =  index;
  }
}
