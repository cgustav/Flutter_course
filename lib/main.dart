import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:flutter/rendering.dart';

//local
//import './product_manager.dart';
import './pages/auth/auth.dart';
import './pages/home/products.dart';
import './pages/myproducts/myproducts.dart';
import './widgets/products/product.dart';
import './models/product.dart';

//scoped
import './scoped-models/main.dart';

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
  final MainModel _model =  MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated){
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModel<MainModel>(
      model: _model,
      child:MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.redAccent,
          buttonColor: Colors.amber,
          ),
          
      //home: AuthPage(),
      routes: {
        //Later you can use the specified named routes with 
        //PushNamed & PushReplacementNamed to navigate through
        //APP views just using a simple string
        '/': (BuildContext context)=>  !_isAuthenticated ? AuthPage(): ProductsPage(_model)
        ,
        // '/products': (BuildContext context) {
        //   return ProductsPage(_model);
        // },
        '/myproducts': (BuildContext context) => !_isAuthenticated ? AuthPage(): MyProductsPage(_model),

      },
      //exception
      onGenerateRoute: (RouteSettings settings) {

        /* NOTES: About onGenerateRoute 
           ------------------------------------------------
           The check at the beginning of onGenerateRoute 
           only catches new navigation actions, not routes
           which were already loaded.
        */

        if(!_isAuthenticated){
          return MaterialPageRoute<bool>(builder: (BuildContext context)=>AuthPage(),);
        }

        //This allow us to pass arguments through name routes
        //for example /product/1
        final List<String> pathElements = settings.name.split('/');

        //Invalid name route
        if (pathElements[0] != '') {
          return null;
        }

        //Valid name route
        if (pathElements[1] == 'product') {
          final String productId = pathElements[2];
          final Product product =  _model.allProducts.firstWhere((Product product){
            return product.id == productId;
          });

          //model.selectProduct(productId);

          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage(): ProductPage(product));
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
                !_isAuthenticated ? AuthPage(): ProductsPage(_model));
      },
    ),);
    

    
  }


}
