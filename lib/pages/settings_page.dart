import 'package:flutter/material.dart';
import 'package:mod3_app/services/auth.dart';

class SettingsPage extends StatefulWidget{

  SettingsPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  @override

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

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
             SizedBox(height: 40.0),
             RaisedButton(
                 child: Text("LOGOUT"),
                 onPressed: signOut,
             ),
           ],
         ),
       ),
    );
  }
}