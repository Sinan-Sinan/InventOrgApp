import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mod3_app/edit_page.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

class ItemPage extends StatefulWidget{
  @override
  final DocumentSnapshot snapshot;
  ItemPage(this.snapshot);
  _ItemPageState createState() => _ItemPageState(snapshot);
}

class _ItemPageState extends State<ItemPage>{
  final DocumentSnapshot document;
  _ItemPageState(this.document);
  @override
  Widget build(BuildContext context){
    return new Scaffold
      (
      body: new Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(width: 90.0,height: 50,
                child: Row(
                  children:<Widget>[
                    Expanded(
                      child: RaisedButton(
                          color: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.blue[50],
                          disabledColor: Colors.transparent,
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.arrow_back, color: Colors.blue, size: 20,),
                              Text('Back',  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue, fontSize:16)),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 150),
            Text(
              document['name'].toString(),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'Location: ' + document['location'].toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Cost: \$' +document['cost'].toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    'Quantity: ' + document['quantity'].toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              RaisedButton(
                  color: Colors.orange,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.orange[50],
                  disabledColor: Colors.transparent,
                  elevation: 2.0,
                  highlightElevation: 0.0,
                  child: Text('Edit Item',  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize:20)),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditPage(document)),
                    );
                  }
              ),
              SizedBox(width: 10),
              RaisedButton(
                  color: Colors.red,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.red[50],
                  disabledColor: Colors.transparent,
                  elevation: 2.0,
                  highlightElevation: 0.0,
                  child: Text('Delete Item',  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize:20)),
                  onPressed: () async {
                    Firestore.instance.collection('Items').document(document.documentID).delete();
                    Navigator.pop(context);
                  }),
            ]
          ),
        ],
      ),
    ),
  );
}
}