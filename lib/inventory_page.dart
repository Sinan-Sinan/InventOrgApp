import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mod3_app/item_page.dart';
import 'package:mod3_app/add_page.dart';
import 'package:flutter/cupertino.dart';

class InventoryPage extends StatefulWidget{
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;
  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: Firestore.instance.collection('Items').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return const Align(child: CupertinoActivityIndicator(), alignment: Alignment.center,);
        return ListView.builder(
          controller: scrollController,
          itemCount:  snapshot.data.documents.length,
          itemBuilder: (ctx, i) =>
              _buildListItem(ctx, snapshot.data.documents[i]),
        );
      }
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.orange,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          ),
          label: 'Add',
          labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20),
          labelBackgroundColor: Colors.orange,
        ),
        SpeedDialChild(
          child: Icon(Icons.import_export, color: Colors.white, size: 35),
          backgroundColor: Colors.orange,
          onTap: () => print('Import'),
          label: 'Import',
          labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20),
          labelBackgroundColor: Colors.orange,
        ),
        SpeedDialChild(
          child: Icon(Icons.android, color: Colors.white),
          backgroundColor: Colors.orange,
          onTap: () => print('AI'),
          label: 'Scan',
          labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20),
          labelBackgroundColor: Colors.orange,
        ),
      ],
    );
  }
  Widget build(BuildContext context){
    return new Scaffold
      (
      body: buildBody(),
      floatingActionButton: buildSpeedDial(),
    );
  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
        title: RaisedButton(
        color: Colors.orange[50],
        highlightColor: Colors.orange[100],
        splashColor: Colors.orange[100],
        disabledColor: Colors.transparent,
        elevation: 0.0,
        highlightElevation: 0.0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Text(document['name'].toString(),  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 30)),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.orange[200])
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemPage(document)),
          );
        },
      ),
    );
  }
}