import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ProxyAnimation transitionAnimation = ProxyAnimation(kAlwaysDismissedAnimation);

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Image.asset('assets/voice_icon.png'),
          onPressed: _onPressTape,
        ),
        title: new Text('home page'),
        actions: <Widget>[
          new IconButton(
            icon: new Image.asset('assets/dance_bar_icon.png'),
            onPressed: _navigate
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: new Center(
        child: new Text('homea Page'),
      ),
    );
  }

  void _navigate () {
    Navigator.pushNamed(context, '/player');
  }

  // 录音
  void _onPressTape () {
    print('点击录音');
  }

}