import 'package:scoped_model/scoped_model.dart';

//locales
import './products.dart';
import './user.dart';

/* Notes: About Mixins
  ----------------------------------------
   Mixins are classes where we merge two 
   or even more classes to use it's func-
   tionalities.
   We can import functionalities from a 
   class B to another class A.

*/

class MainModel extends Model with UserModel, ProductModel{

} 