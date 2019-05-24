import 'package:flutter/material.dart';
//local
import './products.dart';
import './buttonManager.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;

  //constructor w/ positional args
  ProductManager({this.startingProduct});

  //As a named constructor w/ named args
  // - Optional Arg example
  //ProductManager({this.startingProduct}); //optional
  //Instantiation->ProductManager({startingProduct: 'value'})
  // - Required Arg example
  //ProductManager ([this.startingProduct = 'value'])
  //
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  @override
  void initState() {
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldwidget) {
    print('Doing a didupdatewidget()');
    super.didUpdateWidget(oldwidget);
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index){
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: ButtonManager(_addProduct),
      ),
      Expanded(child: Products(_products,deleteProduct: _deleteProduct),)
      //deleteProduct: _deleteProduct
    ]);
  }
}
