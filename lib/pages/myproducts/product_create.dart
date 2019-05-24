import 'package:flutter/material.dart';

class ProductCreateTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(child: Text('Save'), 
        onPressed: (){
          //it slides up a sheet from the bottom of the page
          //into which you can put additional information
          showModalBottomSheet(
          context: context, 
          builder: (BuildContext context){
            return Center(child: Text('WENA'),);
          }
          );
        },
        ),
      ),
    );
    //return Center(child: Text('Under Construction'),);
  }
}
