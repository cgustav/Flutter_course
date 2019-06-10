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

class _ProductsPageState extends State<ProductsPage> {
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
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      //body: ProductManager(products),
      body: _buildProductList(),
    );
  }
}

/* Notes: About RefreshIndicator
      -----------------------------------------------
      RefreshIndicator is a widget that provide a 
      super easy way to trigger a pull (fetching data
      or displaying other widget components) reload
      functionality.

      RefreshIndicator accept a Future Object in 
      the onRefresh parameter. That Future Object 
      will retrieve the new data asyncronously.

     */

Widget _buildProductList() {
  return ScopedModelDescendant(
    builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
        child: Text('No products found :('),
      );

      if (model.displayedProducts.length > 0 && !model.isLoading) {
        content = Products();
      } else if (model.isLoading) {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }

      return RefreshIndicator(
        onRefresh: model.fetchProducts,
        child: content,
      );
    },
  );
}
