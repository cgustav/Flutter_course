import 'package:flutter/material.dart';

//local
import '../../product_manager.dart';
import '../shared/sideBar.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String,String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductsPage(this.products, this. addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ProductManager(this.products, this.addProduct, this.deleteProduct),
    );
  }
}
