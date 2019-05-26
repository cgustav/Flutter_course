import 'package:flutter/material.dart';

//local
import '../../product_manager.dart';
import '../shared/sideBar.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String,dynamic>> products;


  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ProductManager(products),
    );
  }
}
