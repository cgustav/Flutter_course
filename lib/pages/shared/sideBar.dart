import 'package:flutter/material.dart';

//import locales
import '../profile.dart';
import '../products.dart';

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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProductsPage()));
          },
        ),
        ListTile(
          title: Text('My profile'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage()));
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
