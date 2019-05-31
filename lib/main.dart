import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

//local
//import './product_manager.dart';
import './pages/auth/auth.dart';
import './pages/home/products.dart';
import './pages/myproducts/myproducts.dart';
import './widgets/products/product.dart';
import './models/product.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  //List<Map<String, dynamic>> _products = [];
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.redAccent,
          buttonColor: Colors.amber,
          //buttonTheme: ButtonThemeData(textTheme: TextTheme())
          ),
          
      //home: AuthPage(),
      routes: {
        //Later you can use the specified named routes with 
        //PushNamed & PushReplacementNamed to navigate through
        //APP views just using a simple string
        '/': (BuildContext context) {
          return AuthPage();
        },
        '/products': (BuildContext context) {
          return ProductsPage(_products);
        },
        '/myproducts': (BuildContext context) {
          return MyProductsPage(_addProduct, _updateProduct, _deleteProduct, _products);
        }
      },
      //exception
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
          // Map<String,dynamic> item = {
          //   'title':_products[index]['title'],
          //   'description': _products[index]['description'],
          //   'image': _products[index]['image'],
          //   'price': _products[index]['price'],
          // };

          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(_products[index]));
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
                //ProductsPage(_products, _addProduct, _deleteProduct));
                ProductsPage(_products));
      },
    );

    
  }

  //CUSTOM METHODS

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _updateProduct(int index, Product product){
    setState(() {
      _products[index] = product;
    });
  }


}
