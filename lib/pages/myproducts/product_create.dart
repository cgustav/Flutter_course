import 'package:flutter/material.dart';

class ProductCreateTab extends StatefulWidget {
  final Function addProduct;

  ProductCreateTab(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreateTabState();
  }
}

class _ProductCreateTabState extends State<ProductCreateTab> {
  String _titlevalue = '';
  String _descriptionValue = '';
  double _priceValue;

  //HELPERS

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product title'),
      onChanged: (String value) {
        setState(() {
          _titlevalue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product description'),
      onChanged: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titlevalue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/img/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  //BUILD METHOD

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          //Title field
          _buildTitleTextField(),
          //Description field
          _buildDescriptionTextField(),
          //Price field
          _buildPriceTextField(),

          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white, //primary
              onPressed: _submitForm
              )
        ],
      ),
    );
  }
}
