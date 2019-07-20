import 'package:flutter/material.dart';
import 'pages/home/home_page.dart' show HomePage;
import 'pages/account/login_page.dart' show LoginPage;
import 'pages/player/player_page.dart' show PlayerPage;
import 'pages/playlist/playlist_page.dart' show PlayListPage;


void main() {
  runApp(MaterialApp(
    title: 'Welcome to Flutter',
    theme: new ThemeData(
      primaryColor: Colors.white,
    ),
    home: HomePage(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/login': (BuildContext context) => LoginPage(),
      '/player': (BuildContext context) => PlayerPage(),
      '/playlist': (BuildContext context) => PlayListPage(),
    },
  ));
}
