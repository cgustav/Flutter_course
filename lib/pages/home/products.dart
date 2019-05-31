import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//local
//import './displayable/product_manager.dart';
import '../shared/sideBar.dart';
import '../../widgets/products/products.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
         ScopedModelDescendant<ProductModel>(builder: (BuildContext context, Widget child, ProductModel model){
           return  IconButton(
            icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              model.toggleDisplayMode();
            },
          );
         },)
        ],
      ),
      //body: ProductManager(products),
      body: Products(),
    );
  }
}
