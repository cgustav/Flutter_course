//State Management Object
import 'package:scoped_model/scoped_model.dart';

//locales
import '../models/user.dart';

mixin UserModel on Model {
  User _authenticated;

  void login(String email, String password) {
    _authenticated =
        User(id: 'ee8aldk-20019a-fff82711', email: email, password: password);
  }
}


