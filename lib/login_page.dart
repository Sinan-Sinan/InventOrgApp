import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
              child: Text('InventOrg'),
            )
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                  Text(
                    'Login Information',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _email = value.trim(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      onSaved: (value) => _password = value.trim(),
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      // save the fields..
                      final form = _formKey.currentState;
                      form.save();

                      // Validate will return true if is valid, or false if invalid.
                      if (form.validate()) {
                        try {
                          FirebaseUser result =
                          await Provider.of<AuthService>(context).loginUser(
                              email: _email, password: _password);
                          print(result);
                        } on AuthException catch (error) {
                          return _buildErrorDialog(context, error.message);
                        } on Exception catch (error) {
                          return _buildErrorDialog(context, error.toString());
                        }
                      }
                    },
                  ),
                    SizedBox(height: 100,),
                ]))));
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