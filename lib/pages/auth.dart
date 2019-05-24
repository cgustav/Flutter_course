import 'package:flutter/material.dart';

//local
import './products.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('LogIn')),
        backgroundColor: Theme.of(context).accentColor,
        //body: Authentication()
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () {
            // Replacement simply means the current page
            // completely gets replaced with this one.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (BuildContext context) => ProductsPage()),
            );
          },
        ),
      ),
    );
  }
}
