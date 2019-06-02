import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//ui-elements
import '../../ui_elements/title_default.dart';
import '../../models/product.dart';

//scoped
//import '../../scoped-models/products.dart';
import '../../scoped-models/main.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  //ProductPage(this.productId);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print('Back Button Pressed');
          Navigator.pop(
              context, false); //we dont want to delete //customized pop
          return Future.value(false); //to not use the default pop
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildProductImage(product),
              _buildProductTitle(product),
              _buildProductPriceDetail(context, product),
              _buildProductDescriptionDetail(product),
            ],
          ),
        ));
  }

  Widget _buildProductImage(Product item) {
    return FadeInImage(
        placeholder: AssetImage('assets/img/food.jpg'),
        height: 300.0,
        fit: BoxFit.cover,
        image: NetworkImage(item.image));
  }

  Widget _buildProductTitle(Product item) {
    return Row(
      children: <Widget>[
        Expanded(
          //flex: 10,
          child: Container(
              //alignment: MainAxisAlignment.center,
              //color: Colors.lightBlue,
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(item.title)),
        )
      ],
    );
  }

  Widget _buildProductPriceDetail(BuildContext context, Product item) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.0),
            //color: Colors.red,
            child: Text(
              'Price:',
              style: TextStyle(fontFamily: 'Exo2', fontSize: 21.0),
            ),
          ),
        ),
        Flexible(
          flex: 4,

          //   child: Container(
          //   margin: EdgeInsets.only(top: 10.0),
          //   color: Colors.blue,
          //   child: Text('chao'),
          // ),
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
            /* NOTES: About BorderRadius & decoration properties
                     */
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).backgroundColor),
            child: Text(
              '\$' + item.price.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductDescriptionDetail(Product item) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.0),
            //color: Colors.red,
            child: Text(
              'Description:',
              style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: 21.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Flexible(
          flex: 4,

          //   child: Container(
          //   margin: EdgeInsets.only(top: 10.0),
          //   color: Colors.blue,
          //   child: Text('chao'),
          // ),

          child: Container(
            //color: Colors.blue,
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            /* NOTES: About BorderRadius & decoration properties
                     */
            child: Text(
              item.description,
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
