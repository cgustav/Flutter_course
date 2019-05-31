import 'package:scoped_model/scoped_model.dart';

//models
import '../models/product.dart';
import '../models/user.dart';

//class ConnectedProducts extends Model {
mixin ConnectedProducts on Model {
  List<Product> products = [];
  User authenticated;

  int selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: authenticated.email,
        userId: authenticated.id);

    products.add(newProduct);
    selProductIndex = null;
    notifyListeners();
  }
}
