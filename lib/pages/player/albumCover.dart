import 'package:flutter/material.dart';

class AlbumCover extends StatefulWidget {
  
  final Map music;

  const AlbumCover({Key key, @required this.music}) : super(key: key);

  @override
  State createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> {

  bool _isPlaying = false;

  // 上一首音乐 封面
  Map _previous;

  // 下一首音乐 封面
  Map _next;

  void _toggleShowLyric () {}

  @override
  void initState() {
    super.initState();
    print(widget.music);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // player disc
          Positioned(
            child: Container(
              child: Transform(
                child: Container(
                  child: ClipOval(
                    child: Image.network(widget.music['album']['coverImageUrl']),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/player_disc.png'),
                      fit: BoxFit.cover,
                    )
                  ),
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
    );
  }

}