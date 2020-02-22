import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'package:mod3_app/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InventOrg',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryTextTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.white
                )
            )),
        home: new RootPage(auth: new Auth()));
  }
}

/*void main() => runApp(
  ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    builder: (BuildContext context) {
      return AuthService();
    },
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InventOrg',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryTextTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white
              )
          )),
      home: FutureBuilder<FirebaseUser>(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // log error to console
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            // redirect to the proper page
            return snapshot.hasData ? DefaultPage(snapshot.data) : LoginPage();
          } else {
            // show loading indicator
            return LoadingCircle();
          }
        },
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}*/