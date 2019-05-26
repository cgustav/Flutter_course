import 'package:flutter/material.dart';

class StandardAuthForm extends StatelessWidget {
  final BuildContext context;
  final Function setEmail;
  final Function setPassword;
  final Function switchTerms;
  final Function submittion;

  StandardAuthForm(this.context, this.setEmail, this.setPassword,
      this.switchTerms, this.submittion);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.difference),
          image: AssetImage('assets/img/bynight.jpg'),
        )),
        //alignment: AlignmentDirectional(0.0, 0.8),
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
                TextField(
                  decoration: InputDecoration(labelText: 'email', filled: true, fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setEmail(value);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'password', filled: true, fillColor: Colors.white),
                  obscureText: true,
                  onChanged: (String value) {
                    setPassword(value);
                  },
                ),
                SwitchListTile(
                  title: Text('Accept Terms.'),
                  value: false,
                  onChanged: (bool value) {
                    switchTerms(value);
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
                
              ]),),
            )));
    
  }
}
