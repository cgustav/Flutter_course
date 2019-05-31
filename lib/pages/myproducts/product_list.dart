import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListTab extends StatelessWidget {
  final List<Map<String, dynamic>> productList;
  final Function updateProduct;

  ProductListTab(this.productList, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
              width: 60.0,
              height: 60.0,
              child: Image.asset(
                productList[index]['image'],
              )),
          title: Text(
            productList[index]['title'],
            style: TextStyle(
                fontFamily: 'Exo2',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context){
                return ProductEditTab(product: productList[index], updateProduct: updateProduct,productIndex: index,);
              }));
            },
          ),
        );
      },
    );
  }
}
