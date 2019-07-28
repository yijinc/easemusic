import 'dart:io';
import 'dart:convert';

// api 服务来自 https://github.com/Binaryify/NeteaseCloudMusicApi
final String baseURL = 'http://192.168.0.102:3000';

String _getQueryString(Map params) {
  if(params==null) {
    return '';
  }
  List<String> list = [];
  params.forEach((k, v) {
    list.add(k + '=' + v);
  });
  return list.join('&');
}

Future _get(String path, [Map params]) async {
  String url = baseURL + path;
  if(params!=null) {
    url += (url.indexOf('?')==-1 ? '?' : '') + _getQueryString(params);
  }
  print('GET: '+ url);
  try {
    //创建一个HttpClient
    HttpClient httpClient = new HttpClient();
    //打开Http连接
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    //等待连接服务器（会将请求信息发送给服务器）
    var response = await request.close();
    //关闭client后，通过该client发起的所有请求都会中止。
    httpClient.close();
    if (response.statusCode == 200) {
      var json = await response.transform(utf8.decoder).join();
      return jsonDecode(json);
    }
    print('请求失败 response.statusCode: '+ response.statusCode.toString());
    return null;
  } catch (e) {
    print('请求失败 '+ e.toString());
    return null;
  }
}

// 推荐歌单
Future fetchPersonalized() async {
  return await _get('/personalized');
}

// 歌单列表
Future fetchPlaylist(int id) async {
  return await _get('/playlist/detail', {'id': id.toString()});
}

// 获取音乐 url
Future fetchMusic(int musicId) async {
  return await _get('/song/url', {'id': musicId.toString()});
}

/**
 * 排行榜
 * "0": 云音乐新歌榜,
 * "1": 云音乐热歌榜,
 * "2": 网易原创歌曲榜,
 * "3": 云音乐飙升榜,
 * "4": 云音乐电音榜, 
 * */
Future fetchTop(idx) async {
  return await _get('/top/list', {'idx': idx.toString()});
}