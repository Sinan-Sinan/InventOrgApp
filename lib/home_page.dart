import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

class HomePage extends StatefulWidget{
  @override

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return new Scaffold
      (
      body: new Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Home',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}