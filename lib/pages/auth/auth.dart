import 'package:flutter/material.dart';

//local imports
import '../home/products.dart';
import 'standardAuthForm.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  //Map<String,dynamic> _authenticated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Authentication')),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: StandardAuthForm(context, _setEmail, _setPassword, _submittion),
    );
  }

  void _setEmail(String email) {
    setState(() {
      _email = email;
    });
    print('Email is :' + _email);
  }

  void _setPassword(String password) {
    setState(() {
      _password = password;
    });
    print('Email is :' + _password);
  }

  void _submittion(BuildContext context){
    final Map<String, dynamic> credentials = {
                'username': _email,
                'password': _password,
    };

    print('Authenticating... '+ credentials.toString());
    Navigator.pushReplacementNamed(context, '/products');
  }

}
