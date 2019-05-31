import 'package:flutter/material.dart';

//local
//import './displayable/product_manager.dart';
import '../shared/sideBar.dart';
import '../../widgets/products/products.dart';
import '../../models/product.dart';

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
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      //body: ProductManager(products),
      body: Products(products),
    );
  }
}
