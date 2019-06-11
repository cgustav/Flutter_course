import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//helpers
import '../helpers/ensure-visible.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  final TextEditingController _addressInputController = TextEditingController();
  final FocusNode _addressInputFocusNode = FocusNode();
  Uri _staticMapUri;

  /* NOTES: About Listener
     ----------------------------------------------------------    
     -> A listener will continue listening even if the 
        widget is deconstructed or 'hiden'.
     -> To stops this behavior we have to remove the 
        listener with the widget's lifecycle's function
        dispose(). So when widget is destroyed, deconstructed,
        hiden or whatever, the specified listener wont work 
        anymore.
     -> Doing these steps we ensure the prevention of a memory 
        leak.
   */

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);
    //await getStaticMap('Garden Square');
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  //Fetching the image maps state isn't synchronous task
  Future<Null> getStaticMap(String address) async {

    if (address.isEmpty) {
      return;
    }

    final Uri uri =
        Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
          'address': address,
          'key': 'AIzaSyDTusXn2VboYjdgtHTHZgpXbv3FmVnb9Kg'
        });

    //fetch coordinates
    final http.Response response = await http.get(uri);

    //print('RESPONSE : '+ response.body.toString());
    final decodedResponse = json.decode(response.body);
    final formattedAddress =  decodedResponse['results'][0]['formatted_address'];
    final coords =  decodedResponse['results'][0]['geometry']['location'];
    //print('MAPS FETCH RESPONSE: ' + decodedResponse.toString());

    final StaticMapProvider staticMapViewProvider =
        StaticMapProvider('AIzaSyDTusXn2VboYjdgtHTHZgpXbv3FmVnb9Kg');
    final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers([
      //A pin on the map
      Marker('position', 'Position', coords['lat'], coords['lng'])
    ],
        center: Location(coords['lat'], coords['lng']),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);

    setState(() {
      _addressInputController.text = formattedAddress;
      _staticMapUri = staticMapUri;
    });
  }

  //User enter the address
  void _updateLocation() async {
    if (!_addressInputFocusNode.hasFocus) {
       getStaticMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocusNode,
          child: TextField(
            focusNode: _addressInputFocusNode,
            controller: _addressInputController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Snapshot of the address i want to provide
        _staticMapUri != null ? Image.network(_staticMapUri.toString()) : Container(),
      ],
    );
  }
}
