import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//scoped models
import '../../scoped-models/main.dart';

enum AuthMode { SignUp, Login }

class StandardAuthForm extends StatefulWidget {
  final BuildContext context;

  StandardAuthForm(this.context);

  @override
  State<StatefulWidget> createState() {
    return _StandardAuthFormState();
  }
}

class _StandardAuthFormState extends State<StandardAuthForm> {
  final GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final Map<String, dynamic> _credentials = {
    'email': null,
    'password': null,
    'accept': false
  };

  AuthMode _authMode = AuthMode.Login;

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _authFormKey,
          child: Container(
              decoration: BoxDecoration(image: _buildBackgroundImage()),
              padding: EdgeInsets.all(10.0),
              child: Container(
                  //color: Colors.green,
                  // constraints: BoxConstraints(
                  //     maxHeight: 400.0,
                  //     maxWidth: 300.0,
                  //     minWidth: 200.0,
                  //     minHeight: 200.0),
                  child: Center(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    _buildEmailInput(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordInput(),
                    SizedBox(
                      height: 10.0,
                    ),
                    //_authMode == AuthMode.SignUp ?
                    _authMode == AuthMode.SignUp
                        ? _buildConfirmPasswordInput()
                        : Container(),

                    _buildSwitchTile(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSwitchModeButton(),
                    SizedBox(
                      height: 10.0,
                    ),
                    //-------SHOW BUTTON
                    _buildSubmitButton(),
                    //-----END BUTTON
                  ]),
                ),
              ))),
        ));
  }

  //HELPERS

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.difference),
      image: AssetImage('assets/img/bynight.jpg'),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'email', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (String value) {
        RegExp reg = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

        if (value.isEmpty || !reg.hasMatch(value)) {
          return 'Email cannot be empty and should be a valid email.';
        }
      },
      onSaved: (String value) {
        _credentials['email'] = value;
      },
      //onChanged: (String value) => setEmail(value));
    );
  }

  // Widget _buildConfirmPmailInput() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         labelText: 'Confirm E-Mail', filled: true, fillColor: Colors.white),
  //     keyboardType: TextInputType.emailAddress,
  //     validator: (String value) {

  //       if (_emailTextController.text != value) {
  //         return 'Email cannot be empty and should be a valid email.';
  //       }
  //     },
  //     onSaved: (String value) {
  //       _credentials['email'] = value;
  //     },
  //     //onChanged: (String value) => setEmail(value));
  //   );
  // }

  Widget _buildPasswordInput() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.trim().length < 3) {
          return 'Password cannot be empty and should be 3+ characters long.';
        }
      },
      onSaved: (String value) {
        _credentials['password'] = value;
      },
    );
  }

  Widget _buildConfirmPasswordInput() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match.';
        }
      },
      onSaved: (String value) {
        //_credentials['password'] = value;
      },
    );
  }

  Widget _buildSwitchTile() {
    return SwitchListTile(
        title: Text('Accept Terms.'),
        value: _credentials['accept'],
        onChanged: (bool value) => switchTerms(value));
  }

  Widget _buildSwitchModeButton() {
    return FlatButton(
      child:
          Text('Switch to ${_authMode == AuthMode.Login ? 'SignUp' : 'LogIn'}'),
      onPressed: () {
        setState(() {
          _authMode =
              _authMode == AuthMode.Login ? AuthMode.SignUp : AuthMode.Login;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    final String buttonText = _authMode == AuthMode.SignUp ? 'SignUp' : 'LogIn';

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.isLoading
          ? CircularProgressIndicator()
          : RaisedButton(
              //color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Center(
                child: Text(buttonText),
              ),
              onPressed: () => _submitForm(model.login, model.signUp));
    });
  }

  void switchTerms(bool value) {
    setState(() {
      _credentials['accept'] = value;
    });
  }

  void _submitForm(Function login, Function signUp) async {
    if (!_authFormKey.currentState.validate() || !_credentials['accept']) {
      return;
    }

    Map<String, dynamic> successInformation;

    _authFormKey.currentState.save();

    if (_authMode == AuthMode.Login) {
      successInformation =
          await login(_credentials['email'], _credentials['password']);
    } else {
      successInformation =
          await signUp(_credentials['email'], _credentials['password']);
    }

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An error occurred!'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
