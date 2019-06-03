import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import locales
//import '../myproducts/myproducts.dart';
//import '../products.dart';

//locales

import '../../scoped-models/main.dart';

class SideBar extends StatelessWidget {
  //HELPERS

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          //automaticallyImplyLeading just erase the hamburguer icon
          automaticallyImplyLeading: false,
          title: Text('Choose'),
          //NOTE: Actions inside sidebar - looks pretty cool
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.favorite),
          //     onPressed: () {},
          //   )
          // ],
        ),
        //Home
        _buildHomeTile(context),
        //My products
        _buildMyProductsTile(context),
        //Random
        _buildRandomMessageTile(context),
        //..
        Divider(),
        //Log Out
        _buildLogoutTile(context),
      ],
    ));
  }

  Widget _buildHomeTile(BuildContext context) {
    return ListTile(
        title: Text('Home'),
        leading: Icon(Icons.home),
        onTap: () => Navigator.of(context).pushNamed('/products'));
  }

  Widget _buildMyProductsTile(BuildContext context) {
    return ListTile(
        title: Text('My products'),
        leading: Icon(Icons.shop),
        onTap: () => Navigator.of(context).pushNamed('/myproducts'));
  }

  Widget _buildRandomMessageTile(BuildContext context) {
    return ListTile(
        title: Text('Random Message'),
        leading: Icon(Icons.warning),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Danger!'),
                  content: Text('Lifes too short to think about everything!'),
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
        });
  }

  Widget _buildLogoutTile(BuildContext context) {
    ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            model.logOut();
            Navigator.of(context).pushReplacementNamed('/');
          },
        );
      },
    );
  }
}
