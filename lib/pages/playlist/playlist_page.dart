import 'package:flutter/material.dart';
import 'package:easemusic/pages/player/player_page.dart' show storeMusicList;

class PlayListPage extends StatelessWidget {

  final _sortFont = const TextStyle(fontSize: 16.0, color: Colors.grey);

  _navigateMv() {
    print('navigate mv page');
  }
  
  @override
  Widget build(BuildContext context) {

    final Map _playlistInfo = ModalRoute.of(context).settings.arguments;
    final List _tracks = _playlistInfo['playlist']['tracks'];    

    void _playMusic (Map music) {
      storeMusicList = _tracks;
      Navigator.pushNamed(context, '/player', arguments: music);
    }

    Widget _buildRow(Map music, index) {
      List artists =  music['ar'];
      return new ListTile(
        leading: Container(
          child: Text(
            (index+1).toString(),
            style: _sortFont,
          ),
          width: 40,
          alignment: Alignment.center,
        ),
        title: Text(
          music['name'],
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          artists.map((artist) => artist['name']).join('/') + ' - ' + music['al']['name'],
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          child: music['mv']==0? null : IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _navigateMv
          ),
          width: 60,
          alignment: Alignment.centerLeft,
        ),
        contentPadding: EdgeInsets.only(left: 10.0, right: 2.0),
        onTap: () {
          _playMusic(music);
        },
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(_playlistInfo['playlist']['name']),
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        // 对于每个 item 都会调用一次itemBuilder，然后将 item 添加到 ListTile 行中
        itemBuilder: (context, index) {
          return _buildRow(_tracks[index], index);
        },
        itemCount: _tracks.length,
      ),
    );
  }
}

