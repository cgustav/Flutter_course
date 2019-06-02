import 'package:flutter/material.dart';
//import 'package:scoped_model/scoped_model.dart';

//local imports
import '../../widgets/auth/standardAuthForm.dart';



class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _acceptTerms = false;
  //Map<String,dynamic> _authenticated;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Authentication')),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: StandardAuthForm(context),
    );
  }

  

  void _submittion(BuildContext context) {
    final Map<String, dynamic> credentials = {
      'username': _email,
      'password': _password,
    };

    print('Acepta terminos? :' + _acceptTerms.toString());
    print('Authenticating... ' + credentials.toString());
    Navigator.pushReplacementNamed(context, '/products');
  }
}
