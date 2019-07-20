import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Player page'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _navigate),
        ],
      ),
      body: new Center(
        child: new Text('Player Page'),
      ),
    );
  }

  void _navigate () {

  }

}