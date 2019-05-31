import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//ui elements
import '../../ui_elements/title_default.dart';

//state models
import '../../models/product.dart';

//scoped models
//import '../../scoped-models/products.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          //SizedBox(height: 50.0,child: Container(color: Colors.green,)),
          Container(
              //NOTES: About margin
              //->margin top && bottom
              //  /margin:EdgeInsets.only(top: 10.0, bottom: 1.0),
              //  /Here you can specify 'manual' margin configuration
              //
              //->margin symmetrical (horizontal)
              // /margin:EdgeInsets.symmetric(horizontal: 25.0),
              // /You can control the margin size of the container
              // /equally (to the left & to the right)
              //
              //-> or symmetrical (horizontal + vertical)
              //margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.1),

              margin: EdgeInsets.only(top: 0.0),

              //NOTES: About padding
              //-> the same as margin settings options
              //-> Additionaly you can use the Padding widget:
              //    /Padding(padding: EdgeInsets.only(top: 10.0),color: Colors.green,))

              padding: EdgeInsets.only(top: 10.0),
              //
              //color: Colors.green,

              child: Row(
                //NOTES: About Alignment & Rows
                // -> The MainAxisAlignment inside a row acts
                //    from the left to the right (natural row direction)
                // -> In the case the MainAxisAlignment is being used
                //    inside a Column the alignment will start from
                //    the top to the bottom
                mainAxisAlignment: MainAxisAlignment.center,

                //NOTES: About Alignment & CrossAxisAlignment
                // -> It is designed to be the completely opposite to
                //    the MainAxisAlignment property effect.
                //crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  //NOTES: About Expanded Widget
                  // -> It gives the widget which it wraps as much
                  //    space in the row or column you're using it
                  //    as possible.
                  TitleDefault(product.title),
                  SizedBox(
                    width: 8.0,
                  ),
                  /* NOTES: About Box Decoration 
                   *  The BoxDecoration class provides a variety of ways to draw a box.
                   *  The box has a border, a body, and may cast a boxShadow.
                   * 
                   *  The body of the box is painted in layers. The bottom-most layer 
                   *  is the color, which fills the box. Above that is the gradient, 
                   *  which also fills the box. Finally there is the image, the precise 
                   *  alignment of which is controlled by the DecorationImage class.
                   */
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                    /* NOTES: About BorderRadius & decoration properties
                     */
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Theme.of(context).backgroundColor),
                    child: Text(
                      '\$' + product.price.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.5),
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(6.0)),
            child: Text('Union Square, San Francisco.'),
            //Text(''),
          ),
          Text(product.userEmail),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).primaryColorDark,
                onPressed: () {
                  Navigator.pushNamed<bool>(
                      context, '/product/' + productIndex.toString());
                },
                iconSize: 30.0,
              ),
              ScopedModelDescendant<MainModel>(
                builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return IconButton(
                    icon: Icon(model.products[productIndex].isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      //FAVORITE BUTTON
                      model.selectProduct(productIndex);
                      model.toggleProductFavoriteStatus();

                    },
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
