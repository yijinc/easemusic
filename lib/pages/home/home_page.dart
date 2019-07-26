import 'package:flutter/material.dart';
import '../../service/music_service.dart' show fetchPersonalized;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ProxyAnimation transitionAnimation = ProxyAnimation(kAlwaysDismissedAnimation);

  List _playLists = [];

  @override
  void initState() {
    super.initState();
    fetchPersonalized().then((response) {
      if(response==null) {
        return;
      }
      // 将list 转为二维数组
      List list = [];
      response['result'].asMap().forEach((i, v){
        if(i%3==0) {
          list.add([]);
        }
        list[i~/3].add(v);
      });
      setState(() {
        _playLists = list;
      });
    });
  }



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
      body: new SingleChildScrollView(
        child: new Column(
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
            new Center(
              child: new Container(
                child: new Center(
                  child: new Text(
                    '推荐歌单',
                    style: new TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.pink,
                      fontSize: 16,
                    ),
                  ),
                ),
                width: 84,
                height: 24,
                padding: EdgeInsets.only(bottom: 2),
                color: Colors.pink,
                margin: EdgeInsets.only(bottom: 14),
              ),
            ),
            new Column(
              children: _buildPlaylists(),
            ),
            
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),

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
                new Image.asset('assets/calendar.png'),
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

  // 单个 歌单
  Widget _buildPlaylist(Map playList) {
    final TextStyle smallTextStyle = new TextStyle(fontSize: 10, color: Colors.white);
    final TextStyle primaryTextStyle = new TextStyle(fontSize: 12);
    return new GestureDetector(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Image.network(
                  playList['picUrl']+'?param=112y112',
                  width: 112,
                  height: 112,
                ),
                new Positioned(
                  child: new Row(
                    children: <Widget>[
                      new Image.asset('assets/headset_icon_s.png'),
                      new Text(playList['playCount'].toString(), style: smallTextStyle,),
                    ],
                  ),
                  right: 2,
                  top: 2,
                ),
              ],
            ),
            new Text(playList['name'], style: primaryTextStyle, overflow: TextOverflow.ellipsis, maxLines: 2 ),
          ],
        ),
        width: 112,
        height: 150,
        margin: EdgeInsets.only(bottom: 10),
      ),
      onTap: _navigatePlaylist(playList),
    );
  }

  // 歌单
  List<Row> _buildPlaylists() {
    return _playLists.map(
      (playlist2) {
      return new Row(
        children: playlist2.map<Widget>( (play) {
          return _buildPlaylist(play);
        }).toList(),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      );
    }).toList();
  }

  void _navigatePlayer () {
    Navigator.pushNamed(context, '/player');
  }

  void _navigateSearch () {
    print('go to search page');
  }

  _navigatePlaylist (Map params) {
    return () {
      Navigator.pushNamed(context, '/playlist', arguments: params);
    };
  }

  // 录音
  void _onPressTape () {
    print('点击录音');
  }

}