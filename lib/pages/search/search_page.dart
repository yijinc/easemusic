import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Search page'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _navigate),
        ],
      ),
      body: new Center(
        child: new Text('Search Page'),
      ),
    );
  }

  void _navigate () {

  }

}