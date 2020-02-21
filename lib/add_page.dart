import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddPage extends StatefulWidget{
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage>{
  String _name;
  String _location;
  String quantity;
  String cost;
  final _formKey = GlobalKey<FormState>();
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
            Text(
              'Add Item',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection('Items').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return const Align(child: CupertinoActivityIndicator(), alignment: Alignment.center,);
                  return ListView(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                          Card (
                            child: TextFormField(
                                onSaved: (value) => _name = value,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(labelText: "Name of Item:")
                              ),
                            ),
                            Card(
                              child: TextFormField(
                                  onSaved: (value) => _location = value,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(labelText: "Where is the Item Located:")
                              ),
                            ),
                            Card(
                              child: TextFormField(
                                  onSaved: (value) => cost = value.trim(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: "How much does it Cost:"),
                                  validator: (String value) {
                                    return value.contains('-') ? 'Do not use the \'-\' char.' : null;
                                  },
                              ),
                            ),
                            Card(
                              child: TextFormField(
                                  onSaved: (value) => quantity = value.trim(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: "How many are there:"),
                                  validator: (String value) {
                                  return value.contains('-') ? 'Do not use the \'-\' char.' : null;
                                  },
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: RaisedButton(
                                  child: Text("Add"),
                                  onPressed: () async {
                                    // save the fields..
                                    final form = _formKey.currentState;
                                    form.save();

                                    // Validate will return true if is valid, or false if invalid.
                                    if (form.validate()) {
                                      try {
                                        var result = Firestore.instance
                                            .collection('Items')
                                            .document()
                                            .setData({
                                          'name': _name,
                                          'location': _location,
                                          'cost': int.parse(cost),
                                          'quantity': int.parse(quantity)
                                        });
                                        print(result);
                                      } on AuthException catch (error) {
                                        return _buildErrorDialog(
                                            context, error.message);
                                      } on Exception catch (error) {
                                        return _buildErrorDialog(
                                            context, error.toString());
                                      }
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}