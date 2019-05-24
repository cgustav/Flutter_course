import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

//local
//import './product_manager.dart';
import './pages/auth.dart';
import './pages/home/products.dart';
import './pages/myproducts/myproducts.dart';
import './pages/product.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _products = [];

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) =>
            ProductsPage(_products, _addProduct, _deleteProduct),
        '/myproducts': (BuildContext context) => MyProductsPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        //This allow us to pass arguments through name routes
        //for example /product/1
        final List<String> pathElements = settings.name.split('/');

        //Invalid name route
        if (pathElements[0] != '') {
          return null;
        }

        //Valid name route
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          //image url
          //title:_products[index],imageUrl:_products[index]
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(
                  _products[index]['title'], _products[index]['image']));
        }

        //
      },
      onUnknownRoute: (RouteSettings settings) {
        //it is executed inmediately after onGenerateRoute fails
        //if we try to go to a non existing page (for some reason)
        //the app automatically will redirect the client to the 
        //home page.
        
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductsPage(_products, _addProduct, _deleteProduct));
      },
    );
  }
}
