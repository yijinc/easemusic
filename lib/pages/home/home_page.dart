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
        // backgroundColor: Colors.black,
      ),
      body: new Column(
        children: [
          new Row(),
          new Image.asset('assets/banner.png'),
          new Container(
            child: new Row(
              children: <Widget>[
                _buildMenu('assets/headset.png', '私人FM'),
                _buildMenu('assets/calendar.png', '每日推荐'),
                _buildMenu('assets/hot.png', '新歌榜'),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            height: 126,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }


  // 私人FM / 每日推荐 / 新歌榜 菜单
  Widget _buildMenu(String imgSrc, String title) {
    if (title=='每日推荐') {
      var today = new DateTime.now();
      return new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                Image.asset('assets/calendar.png'),
                new Positioned(
                  child: new Center(
                    child: Text('${today.day}'),
                  ),
                  width: 42,
                  height: 42,
                )
              ],
            ),
            new Text(
              '每日推荐',
            )
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        onTap: _navigateSearch,
      );
    } else {
      return new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Image.asset(imgSrc),
            new Text(
              title,
            )
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        onTap: _navigateSearch,
      );
    }

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