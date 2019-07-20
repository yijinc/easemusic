import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Login page'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _navigate),
        ],
      ),
      body: new Center(
        child: new Text('Login Page'),
      ),
    );
  }

  void _navigate () {

  }

}