import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AlbumCover extends StatefulWidget {
  
  final Map music;
  final bool isPlaying;

  const AlbumCover({Key key, @required this.music, this.isPlaying}) : super(key: key);

  @override
  State createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> {

  Map _previous;  // 上一首音乐 封面
  
  Map _next;  // 下一首音乐 封面

  void _toggleShowLyric () {}

  double _rotation = 0; // 旋转角度

  Timer _timer = null;

  @override
  void initState() {
    super.initState();
    if(widget.isPlaying) {
      _startRotation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopRotation();
  }

  @override
  void didUpdateWidget(AlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isPlaying!=widget.isPlaying) {
      if(widget.isPlaying) {
        _startRotation();
      } else {
        _stopRotation();
      }
    }
  }

  void _startRotation() {
    setState(() {
      _rotation = _rotation==360? 1 : _rotation+1;
    });

    _timer = Timer(Duration(milliseconds: 40), _startRotation);
  }

  void _stopRotation() {
    if(_timer!=null) {
      _timer.cancel();
    }
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
                      widget.music['al']['picUrl'] + '?param=180y180', 
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
                  transform: Matrix4.identity()..rotateZ( (widget.isPlaying? 0 : -30) * math.pi / 180),
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