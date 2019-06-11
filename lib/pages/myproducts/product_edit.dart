import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//locales
//helpers
import '../../widgets/helpers/ensure-visible.dart';
//models
import '../../models/product.dart';
//scoped models
import '../../scoped-models/main.dart';
//widgets
import '../../widgets/form_inputs/location.dart';

//
class ProductEditTab extends StatefulWidget {
  //Without constructor
  @override
  State<StatefulWidget> createState() {
    return _ProductEditTabState();
  }
}

class _ProductEditTabState extends State<ProductEditTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image':
        'http://as01.epimg.net/deporteyvida/imagenes/2018/05/07/portada/1525714597_852564_1525714718_noticia_normal.jpg'
  };
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  // String _titlevalue = '';
  // String _descriptionValue = '';
  // double _priceValue;

  //BUILD METHOD

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final Widget pageContent =
          _buildPageContent(context, model.selectedProduct);
      return model.selectedProductIndex == -1
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit product'),
              ),
              body: pageContent,
            );
    });
  }

  //HELPERS

  Widget _buildPageContent(BuildContext context, Product product) {
    //Notes: About Gesture Detectors & Customized Buttons
    //   -> It contains tons of events, it's awesome!
    return GestureDetector(
      onTap: () {
        //we stablish a autofocus action
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
            child: ListView(
              children: <Widget>[
                //Title field
                _buildTitleTextField(product),
                //Description field
                _buildDescriptionTextField(product),
                //Price field
                _buildPriceTextField(product),
                //Separator
                SizedBox(
                  height: 10.0,
                ),
                LocationInput(),
                SizedBox(
                  height: 10.0,
                ),
                //Submit
                _buildSubmitButton(context),
              ],
            ),
          )),
    );
  }

  Widget _buildTitleTextField(Product product) {
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

    /* NOTE: About Validator
      - There is a special argument called we 
        can pass in called validator inside a TextFormField 
        that allows our app to inspect what the client put
        inside a certain form control. 
        Which means, a simply validation mechanism.
      - The argument returned from validator built function
        will be the error message (if there is exists one).
        It can me a string value or null.
    */

    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: Container(
        child: TextFormField(
          focusNode: _titleFocusNode,
          decoration: InputDecoration(labelText: 'Product title'),
          initialValue: product == null ? '' : product.title,
          validator: (String value) {
            //if(value.trim().length <= 0){
            if (value.isEmpty || value.trim().length < 3) {
              return 'Title is required and should be 3+ characters long.';
            }
          },
          onSaved: (String value) {
            _formData['title'] = value;
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocusNode,
        child: Container(
          child: TextFormField(
            focusNode: _descriptionFocusNode,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Product description'),
            initialValue: product == null ? '' : product.description,
            validator: (String value) {
              if (value.isEmpty || value.trim().length < 5) {
                return 'Description is required and should be 5+ characters long.';
              }
            },
            onSaved: (String value) {
              _formData['description'] = value;
            },
          ),
        ));
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _priceFocusNode,
        child: Container(
          child: TextFormField(
            focusNode: _priceFocusNode,
            decoration: InputDecoration(labelText: 'Product price'),
            keyboardType: TextInputType.number,
            initialValue: product == null ? '' : product.price.toString(),
            validator: (String value) {
              if (value.isEmpty ||
                  !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                return 'Price is required and should be a number.';
              }
            },
            onSaved: (String value) {
              _formData['price'] = double.parse(value);
            },
          ),
        ));
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white, //primary
              onPressed: () => _submitForm(
                  model.addProduct,
                  model.updateProduct,
                  model.selectProduct,
                  model.selectedProductIndex),
            );
    });
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    /* Note: About Key States
       ---------------------------------------------
      -With the Save() method, the onSaved 
       event of every form control will be triggered
       Also, the state of the widget will be setted 
       to saved.
      -With the Validate() method, will call the 
       methods inside the validator attributes on all 
       inputs which are wrapped by the Form widget.
       The validate methos will return true if 
       every control pass the validator attr
       or return false if is not.
      
    */

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Future skipper = Navigator.pushReplacementNamed(context, '/products')
        .then((_) => setSelectedProduct(null));

    if (selectedProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((success) {
        if (success) {
          return skipper;
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong.'),
                  content: Text('Please try again later'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ok'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      );
    }
  }

  //END HELPERS
}
