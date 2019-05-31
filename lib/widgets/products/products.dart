import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//import './product.dart';
import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model) {
        return _buildProductList(model.products);
      },
    );
  }

  //INNER COMPONENTS
  Widget _buildProductList(List<Product> products) {
    Widget productCard = Center(
      child: Text('No product found :('),
    );
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return productCard;
  }
}
