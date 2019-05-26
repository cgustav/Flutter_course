import 'package:flutter/material.dart';

import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }

  //
  //INNER COMPONENTS
  Widget _buildProductList() {
    Widget productCard = Center(
      child: Text('No product found :('),
    );
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: _buildProduct,
        itemCount: products.length,
      );
    }
    return productCard;
  }

  Widget _buildProduct(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
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
                  Text(products[index]['title'],
                      //NOTES: Text Style & Fonts
                      //-> You can customize text styling and
                      //   other font configuration with the
                      //   TextStyle widget
                      style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Exo2')),
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
                      '\$' + products[index]['price'].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(6.0)),
            child: Text('Union Square, San Francisco.'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Theme.of(context).primaryColorDark,
                //color: Colors.blueAccent,
                child: Text('View Details',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () => {
                      //Navigator.push<bool>(
                      //context,
                      // MaterialPageRoute(
                      //     builder: (context) => ProductPage(
                      //         products[index]['title'],
                      //         products[index]['image'])))
                      Navigator.pushNamed<bool>(
                          context, '/product/' + index.toString())
                      //     .then((bool value) {
                      //   if (value) {
                      //     deleteProduct(index);
                      //   }
                      //   //print(value)
                      // })
                    },
              )
            ],
          )
        ],
      ),
    );
  }
}
