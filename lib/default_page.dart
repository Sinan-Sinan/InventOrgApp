import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mod3_app/home_page.dart';
import 'package:mod3_app/settings_page.dart';
import 'package:mod3_app/inventory_page.dart';

class DefaultPage extends StatefulWidget {
  @override
  final FirebaseUser currentUser;
  DefaultPage(this.currentUser);
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  final List<Widget> _children = [
    HomePage(),
    InventoryPage(),
    SettingsPage(),
  ];
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InventOrg"),
        //actions: <Widget>[LogoutButton()],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.assignment),
            title: new Text('Inventory'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
