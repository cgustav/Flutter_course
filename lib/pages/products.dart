import 'package:flutter/material.dart';

//local
import '../product_manager.dart';
import './shared/sideBar.dart';

class ProductsPage extends StatelessWidget {
  // void _showDialog(){
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context){
  //       return AlertDialog();
  //     }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('LightList'),
      ),
      body: ProductManager(),
    );
  }
}
