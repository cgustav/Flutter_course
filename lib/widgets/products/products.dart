import 'package:flutter/material.dart';

//import './product.dart';
import './product_card.dart';
class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }

  //INNER COMPONENTS
  Widget _buildProductList() {
    Widget productCard = Center(
      child: Text('No product found :('),
    );
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: _buildProduct,
        itemCount: products.length,
      );
    }
    return productCard;
  }

  Widget _buildProduct(BuildContext context, int index) {
    return ProductCard(products[index], index);
  }
}
