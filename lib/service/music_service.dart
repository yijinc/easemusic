import 'dart:io';
import 'dart:convert';

final String baseURL = 'http://localhost:3000';

final Map error = const {
  'error': '请求失败'
};

Future _get(String path, [Map params]) async {
  String url = baseURL+path;
  if(params!=null) {
    url+='?';
    params.forEach((k, v){
      url+=  k + '=' + v+'&';
    });
  }
  print(url);
  try {
    //创建一个HttpClient
    HttpClient httpClient = new HttpClient();
    //打开Http连接
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    //等待连接服务器（会将请求信息发送给服务器）
    var response = await request.close();
    print(response);
    //关闭client后，通过该client发起的所有请求都会中止。
    httpClient.close();
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      return data['result']; 
    }
    return error;
  } catch (e) {
    print(e);
    return error;
  }
}


Future fetchPersonalized() async {
  return await _get('/personalized', {'a': 'b'});
}