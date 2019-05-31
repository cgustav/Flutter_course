import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//locales
import './product_edit.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class ProductListTab extends StatelessWidget {
  //final List<Product> productList;
  //final Function updateProduct;
  //final Function deleteProduct;

  //ProductListTab(this.productList, this.updateProduct, this.deleteProduct);
  ProductListTab();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model) {
        final List<Product> productList = model.products;
        return ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(productList[index].title),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  //print('swiped end to start');
                  model.deleteProduct(index);
                } else if (direction == DismissDirection.startToEnd) {
                  //print('swiped start to end');
                } else {
                  //print('Other swiping');
                }
                //print('-------------');
                //print('-------------');
                //print('-------------');
                //
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                        width: 40.0,
                        height: 40.0,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            productList[index].image,
                          ),
                        )),
                    title: Text(
                      productList[index].title,
                      style: TextStyle(
                          fontFamily: 'Exo2',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    subtitle: Text('\$ ' + productList[index].price.toString()),
                    trailing: _showEditIconButton(context, index, productList),
                  ),
                  Divider()
                ],
              ),
              //next
            );
          },
        );
      },
    );
  }

  //HELPERS

  Widget _showEditIconButton(BuildContext context, int index, List<Product> productList) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditTab(
            product: productList[index],
            productIndex: index,
          );
        }));
      },
    );
  }
}
