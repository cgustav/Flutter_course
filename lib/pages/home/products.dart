import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//local
//import './displayable/product_manager.dart';
import '../shared/sideBar.dart';
import '../../widgets/products/products.dart';
import '../../models/product.dart';

//scoped models
import '../../scoped-models/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage>{

  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
         ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
           return  IconButton(
            icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              model.toggleDisplayMode();
            },
          );
         },)
        ],
      ),
      //body: ProductManager(products),
      body: Products(),
    );
  }
}
