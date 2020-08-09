import 'package:album_app/router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;

  const SplashScreen({Key key, this.nextRoute}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: Router.routes[widget.nextRoute]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow, child: Center(child: Text("Welcome!")));
  }
}
