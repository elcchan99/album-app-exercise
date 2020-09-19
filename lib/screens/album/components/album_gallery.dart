import 'package:album_app/components/image_with_loading.dart';
import 'package:album_app/constant.dart';
import 'package:album_app/controllers/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumGallery extends GetView<GalleryController> {
  // final GalleryController controller;

  // const AlbumGallery({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<GalleryController>(
      initState: (state) => Get.find<GalleryController>().init(),
      builder: (_) => _.photos.isEmpty
          ? buildEmpty(context)
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _.photos.length,
              itemBuilder: (context, index) => ImageWithLoading(
                  image: _.photos[index].imageUrlWithFixedSize(
                      size.height ~/ 2, size.height ~/ 2)),
            ),
    );
  }

  Widget buildEmpty(context) => Center(
          child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Icon(
              Icons.photo_album,
              size: 100,
              color: kPrimaryColor,
            ),
            Text(
              "No downloaded photos",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: kPrimaryColor),
            )
          ],
        ),
      ));
}
