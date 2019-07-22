import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {

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
              child: Column(
                children: <Widget>[
                  Container(
                    child: Transform(
                      child: Container(
                        child: Image.asset('assets/player_needle.png'),
                      ),
                      // pause: -30 playing: 0
                      transform: Matrix4.identity()..rotateZ( -30 * 3.1415927 / 180),
                      origin: Offset(15, 13),
                    ),
                    // color: Colors.white,
                    height: 134,
                    padding: EdgeInsets.only(left: 62),
                  ),
                  
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(color: Colors.white, icon: Icon(Icons.favorite), onPressed: _share,),
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
                  IconButton(color: Colors.white, icon: Icon(Icons.play_arrow), onPressed: _share, iconSize: 72,),
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

}