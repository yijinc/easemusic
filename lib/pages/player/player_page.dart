import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'albumCover.dart' show AlbumCover;
import '../../service/music_service.dart' show fetchMusic;

AudioPlayer audioPlayer = new AudioPlayer();

List storeMusicList = [];
Map storeMusic = { 'id': 0 };
String storeUrl = '';
bool storeIsPlaying = false;



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
  
  // init state
  Map _music = storeMusic;
  bool _isPlaying = storeIsPlaying;
  bool _isFavorited = false;
  int _currentPosition = 0; // 毫秒

  var _positionSubscription;
  var _audioPlayerStateSubscription;
  bool _isForbidden = false; // 🚫 操作限制

  @override
  void initState() {
    super.initState();

    // 
    audioPlayer.onAudioPositionChanged.listen(onAudioPositionChanged);
    audioPlayer.onPlayerStateChanged.listen(onPlayerStateChanged, onError: onPlayerStateChangedError);

    // 
    if(storeMusicList.length==0) {
      print('播放列表为空 - - ');
      return;
    }
    if(widget.music!=null && _music['id']!=widget.music['id']) {
      //播放选择传来的音乐
      _setMusicAndUrl(widget.music);
      return;
    }
    if(widget.music==null && _music['id']==0) {
      // 默认播放列表第一首
      _setMusicAndUrl(storeMusicList[0]);
      return;
    }

  }

  onAudioPositionChanged (Duration position) {
    if(!_isForbidden) {
      setState(() => _currentPosition = position.inMilliseconds);
    }
  }

  Future onPlayerStateChanged(status) async {
    print('status');
    print(status);

    if (status == AudioPlayerState.PLAYING) {
      // setState(() {
      //   _isPlaying = true
      // });
    } else if (status == AudioPlayerState.COMPLETED) {
      await _next();
    }
  }
  onPlayerStateChangedError(msg) {
    print(msg);
    // setState(() {
    //   playerState = PlayerState.stopped;
    //   duration = new Duration(seconds: 0);
    //   position = new Duration(seconds: 0);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _isForbidden = true;
    storeIsPlaying = _isPlaying;
  }

  Future<void> _setMusicAndUrl(m) async {
    _music = storeMusic = m;
    setState(() {
      _currentPosition = 0;
      _music = storeMusic;
    });
    Map response = await fetchMusic(_music['id']);
    storeUrl = response['data'][0]['url'];
    if(storeUrl==null) {
      _next();
      return;
    }
    if(audioPlayer.state == AudioPlayerState.PLAYING) {
      await audioPlayer.stop();
    }
    await _play();
  }

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


  @override
  Widget build(BuildContext context) {
    List artists =  _music['ar'];
    return Scaffold (
      appBar: AppBar(
        title: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  _music['name'],
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              Center(
                child: Text(
                  artists.map((artist) => artist['name']).join('/') + ' - ' + _music['al']['name'],
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
            
            _buildTimeline(total: _music['dt'], current: _currentPosition, onChanged: _sliderChange),
            // player menu
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(color: Colors.white, icon: Icon(Icons.loop), onPressed: _share,),
                  IconButton(color: Colors.white, icon: Icon(Icons.skip_previous), onPressed: _previous,),
                  IconButton(color: Colors.white, icon: Icon(_isPlaying? Icons.pause_circle_outline : Icons.play_circle_outline), onPressed: _togglePlay, iconSize: 72,),
                  IconButton(color: Colors.white, icon: Icon(Icons.skip_next), onPressed: _next,),
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
    await audioPlayer.play(storeUrl);
    _isForbidden = false;
    if(!_isForbidden) {
      setState(() => _isPlaying = true );
    }
  }

  Future<void> _pause() async {
    await audioPlayer.pause();
    setState(() => _isPlaying = false );
  }

  Future<void> _previous() async {
    _isForbidden = true;
    int index = storeMusicList.indexWhere((m)=>m['id']==_music['id']);
    if(index==-1) {
      await _setMusicAndUrl(storeMusicList[0]);
    } else if(index==0) {
      await _setMusicAndUrl(storeMusicList[storeMusicList.length-1]);
    } else {
      await _setMusicAndUrl(storeMusicList[index-1]);
    }
  }

  Future<void> _next() async {
    _isForbidden = true;
    int index = storeMusicList.indexWhere((m)=>m['id']==_music['id']);
    if(index==-1 || index >= storeMusicList.length-1) {
      await _setMusicAndUrl(storeMusicList[0]);
    } else {
      await _setMusicAndUrl(storeMusicList[index+1]);
    }
  }

  _sliderChange(newRating) {
    setState(() => _currentPosition = (newRating * _music['dt']).toInt());
  }


  void _share () {

  }

  void _goSingerPage () {

  }

  void _toggleShowLyric () {
    print('切换歌词');
  }







  Widget _buildTimeline({int current: 0, int total: 0, Function onChanged}) {
    final int _secondTotal = total ~/ 1000;
    final int _secondCurrent = current ~/ 1000;
    final _styleFont = new TextStyle(fontSize: 10, color: Colors.white);
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              '${_secondCurrent~/60}:${_secondCurrent%60}',
              style: _styleFont,
            ),
            width: 26,
            alignment: Alignment.centerRight,
          ),
          Expanded(
            child: Slider(
              min: 0.0,
              max: 1.0,
              value: current/total,
              onChanged: onChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              label: 'sdls',
              onChangeStart: (_) => _isForbidden = true,
              onChangeEnd: (double rate) {
                audioPlayer.seek(total * rate / 1000);
                _isForbidden = false;
              },
            ),
          ),
          Container(
              child: Text(
              '${_secondTotal~/60}:${_secondTotal%60}',
              style: _styleFont,
            ),
            width: 26,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
    );
  }
}