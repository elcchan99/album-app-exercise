import 'package:album_app/screens/album/album_detail_screen.dart';
import 'package:album_app/screens/album/album_list_screen.dart';
import 'package:album_app/screens/error/not_found.dart';
import 'package:album_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Router {
  static Map<String, Widget Function(BuildContext context, {Object args})>
      routes = {
    SplashScreen.routeName: (_, {args}) =>
        SplashScreen(nextRoute: AlbumListScreen.routeName),
    AlbumListScreen.routeName: (_, {args}) => AlbumListScreen(),
    AlbumDetailScreen.routeName: (_, {args}) =>
        AlbumDetailScreen(photo: (args as AlbumDetailScreenArgs).photo),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    String routeName = settings.name;
    Object args = settings.arguments;
    print("routeName: $routeName, args: $args");

    if (routes.containsKey(routeName)) {
      return MaterialPageRoute(
          builder: (context) {
            return routes[routeName](context, args: args);
          },
          fullscreenDialog: false);
    }
    return MaterialPageRoute(builder: (_) => NotFoundScreen());
  }
}
