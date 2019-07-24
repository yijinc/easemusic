import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {

  bool _isPlaying = false;
  bool _isFavorited = true;

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  '情非得已歌名',
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              Center(
                child: Text(
                  '作者',
                  style: TextStyle(fontSize: 12,),
                ),),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: _share),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  // player disc
                  Positioned(
                    child: Container(
                      child: Transform(
                        child: Container(
                          child: Image.asset('assets/player_disc.png'),
                        ),
                        transform: Matrix4.identity()..rotateZ( 0 * 3.1415927 / 180),
                        alignment: Alignment.center,
                      ),
                      // color: Colors.red,
                      height: 261,
                      width: 261,
                    ),
                    top: 100,
                    width: 261,
                    height: 261,
                  ),

                  // player needle
                  Positioned(
                    child: GestureDetector(
                      child: Container(
                        child: Transform(
                          child: Container(
                            child: Image.asset('assets/player_needle.png'),
                          ),
                          // pause: -30 playing: 0
                          transform: Matrix4.identity()..rotateZ( 0 * 3.1415927 / 180),
                          origin: Offset(15, 13),
                        ),
                        // color: Colors.white,
                        height: 134,
                        padding: EdgeInsets.only(left: 62),
                      ),
                      onTap: _toggleShowLyric,
                    ),
                    top: 20,
                    height: 134,
                  ),
                  
                ],
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(color: _isFavorited? Colors.red : Colors.white, icon: Icon(_isFavorited? Icons.favorite : Icons.favorite_border), onPressed: _toggleFavorite,),
                  IconButton(color: Colors.white, icon: Icon(Icons.save_alt), onPressed: _share,),
                  IconButton(color: Colors.white, icon: Icon(Icons.chat), onPressed: _share,),
                  IconButton(color: Colors.white, icon: Icon(Icons.reorder), onPressed: _share,),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
            ),
            // player menu
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(color: Colors.white, icon: Icon(Icons.loop), onPressed: _share,),
                  IconButton(color: Colors.white, icon: Icon(Icons.skip_previous), onPressed: _share,),
                  IconButton(color: Colors.white, icon: Icon(_isPlaying? Icons.pause_circle_outline : Icons.play_circle_outline), onPressed: _togglePlay, iconSize: 72,),
                  IconButton(color: Colors.white, icon: Icon(Icons.skip_next), onPressed: _share,),
                  IconButton(color: Colors.white, icon: Icon(Icons.queue_music), onPressed: _share,),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            ),
          ],
        ),
        color: Colors.black54,
      ),
    );
  }

  void _share () {

  }

  void _goSingerPage () {

  }

  void _toggleShowLyric () {
    print('切换歌词');
  }

}