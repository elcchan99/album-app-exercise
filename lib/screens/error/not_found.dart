import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String routeName;
  const NotFoundScreen({Key key, this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No route defined for $routeName')),
    );
  }
}
