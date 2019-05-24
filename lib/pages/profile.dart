import 'package:flutter/material.dart';

//import locales

import './shared/sideBar.dart';
// class ProfilePage extends StatefulWidget{

// }

// class _ProfileState extends State<ProfilePage> {

// }

class ProfilePage extends StatelessWidget {
  ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('LightList'),
      ),
      body: Container(
        child: Center(
          child: Text('Under Construction...'),
        ),
      ),
    );
  }
}
