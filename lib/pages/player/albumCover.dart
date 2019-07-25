import 'package:flutter/material.dart';
import 'dart:math' as math;

class AlbumCover extends StatefulWidget {
  
  final Map music;

  const AlbumCover({Key key, @required this.music}) : super(key: key);

  @override
  State createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> {

  bool _isPlaying = false;

  Map _previous;  // 上一首音乐 封面
  
  Map _next;  // 下一首音乐 封面

  void _toggleShowLyric () {}

  double _rotation = 0; // 旋转角度

  Future _rotationTimer = null;

  @override
  void initState() {
    super.initState();
    print(widget.music);

    _startRotation();
  }

  void _startRotation() {
    setState(() {
      _rotation = _rotation==360? 1 : _rotation+1;
    });
    _rotationTimer = Future.delayed(Duration(milliseconds: 40), _startRotation);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // player disc
          Positioned(
            child: Container(
              child: Transform.rotate(
                child: Container(
                  child: ClipOval(
                    child: Image.network(
                      widget.music['album']['coverImageUrl'], 
                      width: 180,
                      height: 180,
                    ),

                  ),
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/player_disc.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                angle: math.pi * _rotation / 180,
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