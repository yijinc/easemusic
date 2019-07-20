import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('home page'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _navigate),
        ],
      ),
      body: new Center(
        child: new Text('home Page'),
      ),
    );
  }

  void _navigate () {
    Navigator.pushNamed(context, '/login');
  }

}