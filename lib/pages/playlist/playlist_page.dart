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
      padding: const EdgeInsets.all(10),
      // 对于每个 item 都会调用一次itemBuilder，然后将 item 添加到 ListTile 行中
      itemBuilder: (context, index) {
        return _buildRow(_tracks[index], index);
      },
      itemCount: _tracks.length,
    );
  }

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _sortFont = const TextStyle(fontSize: 16.0, color: Colors.grey);
  final _smallFont = const TextStyle(fontSize: 15.0, color: Colors.grey);

  Widget _buildRow(Map music, index) {
    List artists =  music['ar'];
    return new ListTile(
      leading: Text(
        (index+1).toString(),
        style: _sortFont,
      ),
      title: Column(
        children: <Widget>[
          Text(
            music['name'],
            style: _biggerFont,
          ),
          Text(
            artists.map((artist) => artist['name']).join('-'),
            style: _smallFont,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      trailing: Icon(
        Icons.play_arrow,
      ),
      // toggle 收藏 / 删除
      onTap: () {
        // 播放
      },
    );
  }

}