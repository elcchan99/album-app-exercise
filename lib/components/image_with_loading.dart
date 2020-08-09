import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageWithLoading extends StatelessWidget {
  final String image;

  const ImageWithLoading({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(child: CircularProgressIndicator()),
      Center(
          child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: image,
      ))
    ]);
  }
}
