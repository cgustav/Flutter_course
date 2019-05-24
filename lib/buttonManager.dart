import 'package:flutter/material.dart';

class ButtonManager extends StatelessWidget{
  final Function addProduct;

  ButtonManager(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  addProduct({'title':'Chocolate', 'image':'assets/food.jpg'});
                },
                child: Text('Add Product'),
              );
  }
}