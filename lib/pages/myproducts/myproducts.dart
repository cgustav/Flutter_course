import 'package:flutter/material.dart';

//import locales

import '../shared/sideBar.dart';
import '../myproducts/product_edit.dart';
import '../myproducts/product_list.dart';
import '../../models/product.dart';


class MyProductsPage extends StatelessWidget {

  final List<Product> productList;

  MyProductsPage(this.productList);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: SideBar(),
          appBar: AppBar(
            title: Text('My Products'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.add_shopping_cart),
                  text: 'Create Product',
                ),
                Tab(
                  icon: Icon(Icons.shopping_basket),
                  text: 'My Products List',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[ProductEditTab(), ProductListTab(),],
          ),
        ));
  }
}
