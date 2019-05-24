import 'package:flutter/material.dart';
//local
import './products.dart';
import './buttonManager.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String,String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: ButtonManager(addProduct),
      ),
      Expanded(child: Products(products,deleteProduct: deleteProduct),)
      //deleteProduct: _deleteProduct
    ]);
  }
}
