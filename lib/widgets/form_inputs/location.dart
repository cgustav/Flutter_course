import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

//helpers
import '../helpers/ensure-visible.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
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
    getStaticMap();
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  //Fetching the image maps state isn't synchronous task
  void getStaticMap() async {
    final StaticMapProvider staticMapViewProvider =
        StaticMapProvider('AIzaSyDTusXn2VboYjdgtHTHZgpXbv3FmVnb9Kg');
    final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers([
      //A pin on the map
      Marker('position', 'Position', 41.40338, 2.17403)
    ],
        center: Location(41.40338, 2.17403),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);

        setState(() {
          _staticMapUri =  staticMapUri;
        });
  }

  void _updateLocation() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocusNode,
          child: TextField(
            focusNode: _addressInputFocusNode,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Snapshot of the address i want to provide
        Image.network(_staticMapUri.toString())
      ],
    );
  }
}
