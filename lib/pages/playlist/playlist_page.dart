import 'package:flutter/material.dart';
import '../../service/music_service.dart' show fetchPlaylist;

class PlayListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final Map _playlistInfo = ModalRoute.of(context).settings.arguments;
    print(_playlistInfo);
    return new Scaffold(
      appBar: AppBar(
        title: Text(_playlistInfo['name']),
      ),
      body: _PlayListView(playlistId: _playlistInfo['id']),
    );
  }
}

class _PlayListView extends StatefulWidget {
  
  _PlayListView({Key key, this.playlistId: 0}) : super(key: key);

  final int playlistId ;

  @override
  createState() => new _PlayListViewState();
}

class _PlayListViewState extends State<_PlayListView> {

  List _tracks = [];

  @override
  void initState() {
    super.initState();
    fetchPlaylist(widget.playlistId).then((response){
      if(response==null) {
        return;
      }
      setState(() {
        _tracks = response['playlist']['tracks'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      // 对于每个 item 都会调用一次itemBuilder，然后将 item 添加到 ListTile 行中
      itemBuilder: (context, index) {
        return _buildRow(_tracks[index], index);
      },
      itemCount: _tracks.length,
    );
  }

  final _sortFont = const TextStyle(fontSize: 16.0, color: Colors.grey);

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

  void _playMusic (Map music) {
    Navigator.pushNamed(context, '/player', arguments: music);
  }

  _navigateMv() {
    print('navigate mv page');
  }

}