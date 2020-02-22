import 'package:flutter/material.dart';
import 'package:mod3_app/pages/home_page.dart';
import 'package:mod3_app/pages/settings_page.dart';
import 'package:mod3_app/pages/inventory_page.dart';
import 'package:mod3_app/services/auth.dart';

class DefaultPage extends StatefulWidget {

  DefaultPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DefaultPageState createState() => _DefaultPageState();
}



class _DefaultPageState extends State<DefaultPage> {
  List<Widget> _children() => [
    HomePage(
      userId: widget.userId,
      auth: widget.auth,
      logoutCallback: widget.logoutCallback,
    ),
    InventoryPage(),
    SettingsPage(
      userId: widget.userId,
      auth: widget.auth,
      logoutCallback: widget.logoutCallback,
    )];
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    final List<Widget> children = _children();
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text('InventOrg'),
          )
      ),
      body: children[_currentIndex], // new
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
