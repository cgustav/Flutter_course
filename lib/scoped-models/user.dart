//State Management Object
import 'package:scoped_model/scoped_model.dart';

//locales
import '../models/user.dart';
import './connected_product.dart';

//class UserModel extends ConnectedProducts
mixin UserModel on ConnectedProducts {

  void login(String email, String password) {
    authenticated = User(id: 'ee8aldk-20019a-fff82711', email: email, password: password);
    print('logeando dentro de la clase...');
    print('email:'+ authenticated.email.toString());
    print('password:'+ authenticated.password.toString());
  }
}


