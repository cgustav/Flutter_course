import 'package:flutter/material.dart';
import 'dart:async';

//ui-elements
import '../../ui_elements/title_default.dart';
import '../../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product item;

  ProductPage(this.item);

  Widget _buildProductTitle() {
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

  Widget _buildProductPriceDetail(BuildContext context) {
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

  Widget _buildProductDescriptionDetail() {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back Button Pressed');
        Navigator.pop(context, false); //we dont want to delete //customized pop
        return Future.value(false); //to not use the default pop
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(item.title),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(item.image),
            _buildProductTitle(),
            _buildProductPriceDetail(context),
            _buildProductDescriptionDetail(),

          ],
        ),
      ),
    );
  }

  // _showWarningDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Are you sure?'),
  //           content: Text('This action cannot be undone!'),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('Confirm'),
  //               onPressed: () {
  //                 Navigator.pop(context); //close the dialog
  //                 Navigator.pop(context,
  //                     true); //Navigates away with true value to delete product
  //               },
  //             ),
  //             FlatButton(
  //               child: Text('Discard'),
  //               onPressed: () {
  //                 Navigator.pop(context); //deletes content
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }
}
