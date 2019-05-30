import 'package:flutter/material.dart';

class StandardAuthForm extends StatefulWidget {
  final BuildContext context;

  StandardAuthForm(this.context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StandardAuthFormState();
  }
}

class _StandardAuthFormState extends State<StandardAuthForm>{
  final GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();
  //String _email = null;
  //String _password = null;
  //bool _acceptTerms = false;
  final Map<String, dynamic> _credentials = {
    'email': null,
    'password': null,
    'accept': false
  };

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                  height: 20.0,
                ),
                _buildSwitchTile(),
                _buildSubmittionButton()
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

  Widget _buildPasswordInput() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'password', filled: true, fillColor: Colors.white),
      obscureText: true,
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

  Widget _buildSwitchTile() {
    return SwitchListTile(
        title: Text('Accept Terms.'),
        value: _credentials['accept'],
        onChanged: (bool value) => switchTerms(value));

  }

  Widget _buildSubmittionButton() {
    return RaisedButton(
        //color: Theme.of(context).accentColor,
        textColor: Colors.white,
        child: Center(
          child: Text('LogIn'),
        ),
        onPressed: () => _submitForm());
  }

  void switchTerms(bool value) {
    setState(() {
      _credentials['accept'] = value;
    });
  }

  void _submitForm() {
    if (!_authFormKey.currentState.validate() || !_credentials['accept']) {
      return;
    } 

    print('Authenticating...');
    _authFormKey.currentState.save();
    print(_credentials.toString());
    Navigator.pushReplacementNamed(context, '/products');
  }


}
