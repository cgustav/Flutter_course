import 'package:flutter/material.dart';

import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products(this.products, {this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }

  //
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
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.blueAccent,
                child: Text('View Details',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () => {
                      //Navigator.push<bool>(
                      //context,
                      // MaterialPageRoute(
                      //     builder: (context) => ProductPage(
                      //         products[index]['title'],
                      //         products[index]['image'])))
                      Navigator.pushNamed<bool>(context, '/product/'+ index.toString())
                          .then((bool value) {
                        if (value) {
                          deleteProduct(index);
                        }
                        //print(value)
                      })
                    },
              )
            ],
          )
        ],
      ),
    );
  }
}
