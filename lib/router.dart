import 'package:album_app/screens/album/album_list_screen.dart';
import 'package:album_app/screens/error/not_found.dart';
import 'package:album_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Map<String, Widget Function(BuildContext context)> routes = {
    "/": (_) => SplashScreen(nextRoute: "/albums"),
    "/albums": (_) => AlbumListScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    String routeName = settings.name;
    if (!routes.containsKey(routeName)) {
      return MaterialPageRoute(builder: routes[routeName]);
    }
    return MaterialPageRoute(builder: (_) => NotFoundScreen());
  }
}
