import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//locales
import './product_edit.dart';
//models
import '../../models/product.dart';
//scope models
//import '../../scoped-models/products.dart';
import '../../scoped-models/main.dart';
//import '';

class ProductListTab extends StatefulWidget {
  final MainModel model;

  ProductListTab(this.model);

  @override
  State<StatefulWidget> createState() {

    return _ProductListTabState();
  }
}

class _ProductListTabState extends State<ProductListTab> {


  @override
  void initState() {
    widget.model.fetchProducts(onlyForUser: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final List<Product> productList = model.allProducts;

        return ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(productList[index].title),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection direction) {
                model.selectProduct(model.allProducts[index].id);
                if (direction == DismissDirection.endToStart) {
                  //print('swiped end to start');
                  model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  //print('swiped start to end');
                } else {
                  //print('Other swiping');
                }

              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                        width: 40.0,
                        height: 40.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
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
                    trailing: _showEditIconButton(context, index, model),
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

  Widget _showEditIconButton(
      BuildContext context, int index, MainModel model) {
    // return ScopedModelDescendant<ProductModel>(
    //   builder: (BuildContext context, Widget child, ProductModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditTab();
        }))
        .then((_)=>{
          model.selectProduct(null)
        });
      },
    );
    //   },
    // );
  }
}
