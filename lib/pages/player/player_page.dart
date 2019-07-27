import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'albumCover.dart' show AlbumCover;
import '../../service/music_service.dart' show fetchMusic;

AudioPlayer audioPlayer = new AudioPlayer();
Map defaultMusic = { 'id': 0 };


class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map _args = ModalRoute.of(context).settings.arguments;
    return _PlayerView(music: _args);
  }
}

class _PlayerView extends StatefulWidget {

  _PlayerView({Key key, this.music}) : super(key: key);

  final Map music;
  
  @override
  State<StatefulWidget> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView> {

  Map _music = defaultMusic;

  @override
  void initState() {
    print(widget.music);
    super.initState();
    if(widget.music!=null && _music['id']!=widget.music['id']) {
      _music = widget.music;
      fetchMusic(_music['id']).then((response){
        _music['url'] = response['data'][0]['url'];
        defaultMusic = _music;
        _play();
      });
    }
  }

  bool _isPlaying = false;
  bool _isFavorited = true;

  void _togglePlay() {
    if(_isPlaying) {
      _pause();
    } else {
      _play();
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  final _positionSubscription = audioPlayer.onAudioPositionChanged.listen((positon) {
    // 格式 0:00:00:00000
  });

  final _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((status) {
    print('status');
    print(status);
    if (status == AudioPlayerState.PLAYING) {
      // setState(() => duration = audioPlayer.duration);
    } else if (status == AudioPlayerState.STOPPED) {
      // onComplete();
      // setState(() {
      //   position = duration;
      // });
    }
  }, onError: (msg) {
    print(msg);
    // setState(() {
    //   playerState = PlayerState.stopped;
    //   duration = new Duration(seconds: 0);
    //   position = new Duration(seconds: 0);
    // });
  });

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
              child: AlbumCover(music: _music, isPlaying: _isPlaying)
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

  Future<void> _play() async {
    await audioPlayer.play(_music['url']);
    setState(() => _isPlaying = true );
  }

  Future<void> _pause() async {
    await audioPlayer.pause();
    setState(() => _isPlaying = false );
  }


  void _share () {

  }

  void _goSingerPage () {

  }

  void _toggleShowLyric () {
    print('切换歌词');
  }

}