import 'package:flutter/material.dart';

import 'package:album_app/components/image_with_loading.dart';
import 'package:album_app/models/photo_model.dart';

class AlbumDetailScreen extends StatelessWidget {
  static const String routeName = "/photo";

  final PhotoModel photo;
  const AlbumDetailScreen({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(photo.title),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * .05, horizontal: size.width * .02),
          child: Container(
              child: Column(
            children: [
              Hero(
                child: SizedBox(
                    width: 500,
                    height: 500,
                    child: ImageWithLoading(image: photo.image)),
                tag: photo.image,
              ),
              SizedBox(height: 20),
              Text(photo.description),
            ],
          )),
        ));
  }
}

class AlbumDetailScreenArgs {
  final PhotoModel photo;

  AlbumDetailScreenArgs({this.photo});

  @override
  String toString() => 'AlbumDetailScreenArgs(photo: $photo)';
}
