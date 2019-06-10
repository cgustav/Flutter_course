import 'package:flutter/material.dart';

/* NOTE: About Models
   ---------------------------------------------
  -> This is like an object template. Reflecting
     some data structure from a back-end service.
     
  -> We dont need to storage an user password.
     Since this is a model to store and manage
     data of an authenticated user in memory.
     Store sensible data like passwords might
     be an unnecesary risk to take in the 
     client side.

 */
class User {
  final String id;
  final String email;
  final String token;

  User({@required this.id, @required this.email, @required this.token});
}
