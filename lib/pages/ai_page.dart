import 'package:flutter/material.dart';

class AIPage extends StatefulWidget{
  @override

  _AIPageState createState() => _AIPageState();
}

class _AIPageState extends State<AIPage>{
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
            SizedBox(height: 20.0),
            Text(
              'AI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            FloatingActionButton(
              //onPressed: _getImageAndDetectFace,
              tooltip: 'Pick an Image',
              child: Icon(Icons.add_a_photo),
              onPressed: (){ print('hi'); },
            ),
          ],
        ),
      ),
    );
  }
}