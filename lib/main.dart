import 'package:album_app/constant.dart';
import 'package:album_app/utils/color_util.dart';
import 'package:album_app/router.dart' as approuter;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Album App',
        theme: ThemeData(
          primarySwatch: kPrimaryColor.toMaterialByOpacity(),
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          textTheme: TextTheme(
              headline1: TextStyle(color: kSecondaryColor),
              headline2: TextStyle(color: kTertiaryColor),
              headline3: TextStyle(color: kSecondaryColor),
              headline4: TextStyle(color: kTertiaryColor),
              headline5: TextStyle(color: kSecondaryColor),
              headline6: TextStyle(color: kTertiaryColor),
              bodyText1: TextStyle(color: kFontColor),
              bodyText2: TextStyle(color: kFontColor)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        onGenerateRoute: approuter.Router.generateRoute);
  }
}
