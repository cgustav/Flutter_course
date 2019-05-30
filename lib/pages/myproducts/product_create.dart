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
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>(); 
  String _titlevalue = '';
  String _descriptionValue = '';
  double _priceValue;

  //HELPERS

  Widget _buildTitleTextField() {
    /* NOTE: About TextFormFields
      - These are special text fields that can be
        integrated into such a form
      - By default it cannot support features like
        onChange events since TxtFormFields can be
        managed as a collective and therefore we can
        manage the values of each field differently.
      - Instead, these widgets can support the onsaved
        event, which means, they trigger a certain function
        every time a form is submitted.
     */
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product title'),
      onSaved:(String value){
        setState(() {
          _titlevalue =  value;
        });
        //print('Title field saved.');
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product description'),
      onSaved:(String value){
          setState(() {
            _descriptionValue = value;
          });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      onSaved:(String value){
          setState(() {
            _priceValue = double.parse(value);
          });
      },
    );
  }

  void _submitForm() {
    /*
      with this line of code, the onSaved event of 
      of every form control will be triggered
      Also, the state of the widget will be setted 
      to saved.
    */
    _formKey.currentState.save();

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
      /* NOTE: About Forms 
       - Forms are actually invisible widgets
       - Forms allow us to manage operations like 
         validations, text input controls, and so on.
       - The key attribute is some kind of global
         identifier that allow us to access this
         form object from other parts of our app.
       */
      child: Form(
        key: _formKey,
        child:ListView(
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
          //Notes: About Customized Button
          //   -> It contains tons of events, it's awesome!
          // GestureDetector(child:  
          //   Container(color:Colors.green,
          //     padding: EdgeInsets.all(15.0),
          //     child: Text('My Button'),)
          // ,
          // )
         
        ],
      ),
    ));
  }
}
