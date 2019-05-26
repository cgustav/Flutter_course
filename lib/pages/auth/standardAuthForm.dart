import 'package:flutter/material.dart';

class StandardAuthForm extends StatelessWidget {
  final BuildContext context;
  final Function setEmail;
  final Function setPassword;
  final Function submittion;

  StandardAuthForm(this.context, this.setEmail, this.setPassword, this.submittion);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional(0.0, 0.6),
        margin: EdgeInsets.all(10.0),
        child: Container(
          //color: Colors.green,
          constraints: BoxConstraints(
              maxHeight: 400.0,
              maxWidth: 300.0,
              minWidth: 200.0,
              minHeight: 200.0),
          child: ListView(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setEmail(value);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
              onChanged: (String value) {
                setPassword(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Center(
                child: Text('LogIn'),
              ),
              onPressed: () {
                // print('im being pressed!!');
                // Navigator.pushReplacementNamed(context, '/products');
                submittion(context);
              },
            )
          ]),
        ));
    ;
  }
}
