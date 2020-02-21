import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context){
    return new Scaffold
      (
       body: new Center(
         child: Column(
           children: <Widget>[
             SizedBox(height: 20.0),
             Text(
               'Settings',
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
             ),
             SizedBox(height: 20.0),
             SizedBox(height: 20.0),
             RaisedButton(
                 child: Text("LOGOUT"),
                 onPressed: () async {
                   await Provider.of<AuthService>(context).logout();
                 })
           ],
         ),
       ),
    );
  }
}