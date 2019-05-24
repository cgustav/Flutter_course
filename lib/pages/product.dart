import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

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
          title: Text(title),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            //  RaisedButton(
            //    child: Text('Back'),
            //    onPressed: ()=>{Navigator.pop(context)},
            //  )
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('DELETE'),
                //onPressed: () => {Navigator.pop(context, true)},
                onPressed:()=>_showWarningDialog(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.pop(context); //close the dialog
                  Navigator.pop(context, true); //Navigates away with true value to delete product
                },
              ),
              FlatButton(
                child: Text('Discard'),
                onPressed: () {
                  Navigator.pop(context); //deletes content
                },
              ),
            ],
          );
        });
  }
}
