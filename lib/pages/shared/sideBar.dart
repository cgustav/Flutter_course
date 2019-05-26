import 'package:flutter/material.dart';

//import locales
//import '../myproducts/myproducts.dart';
//import '../products.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          //automaticallyImplyLeading just erase the hamburguer icon
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => ProductsPage()));
            Navigator.of(context).pushNamed('/products');
          },
        ),
        ListTile(
          title: Text('My products'),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => MyProductsPage()));
          Navigator.of(context).pushNamed('/myproducts');
          },
        ),
        ListTile(
            title: Text('Random Message'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Danger!'),
                      content:
                          Text('Lifes too short to think about everything!'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            }),
      ],
    ));
  }
}
