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
        title: new GestureDetector(
          child: new Container(
            child: new Center(
              child: new Text(
                '搜索音乐、歌词、电台',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.grey[400],
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ),
            height: 30,
            // width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(
                const Radius.circular(6.0),
              ), 
            ),
          ),
          onTap: _navigateSearch,
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Image.asset('assets/dance_bar_icon.png'),
            onPressed: _navigatePlayer
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: new Center(
        child: new Text('homea Page'),
      ),
    );
  }

  void _navigatePlayer () {
    Navigator.pushNamed(context, '/player');
  }

  void _navigateSearch () {
    print('go to search page');
  }

  // 录音
  void _onPressTape () {
    print('点击录音');
  }

}