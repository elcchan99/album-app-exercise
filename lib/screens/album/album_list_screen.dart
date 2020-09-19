import 'package:album_app/controllers/album_controller.dart';
import 'package:album_app/controllers/photo_download_controller.dart';
import 'package:album_app/data/models/photo_model.dart';
import 'package:album_app/screens/album/album_detail_screen.dart';
import 'package:album_app/screens/album/components/album_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumListScreen extends StatelessWidget {
  static const String routeName = "/ablum";

  final AlbumController albumController = Get.put(AlbumController());
  final PhotoDownloadController downloadController =
      Get.put(PhotoDownloadController());

  static const int pageSize = 12;

  // static final photos = <PhotoModel>[
  //   PhotoModel(
  //       title: "Viverra orci",
  //       image: "https://picsum.photos/456",
  //       description:
  //           "Ac tortor vitae purus faucibus ornare. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean."),
  //   PhotoModel(
  //       title: "Feugiat",
  //       image: "https://picsum.photos/1100",
  //       description:
  //           "Feugiat in fermentum posuere urna nec tincidunt praesent. Ac tortor vitae purus faucibus ornare. "),
  //   PhotoModel(
  //       title: "Mi bibendum",
  //       image: "https://picsum.photos/789",
  //       description:
  //           "Mi bibendum neque egestas congue quisque egestas diam in arcu. Ultricies tristique nulla aliquet enim tortor at auctor urna nunc."),
  //   PhotoModel(
  //       title: "Quam pellentesque",
  //       image: "https://picsum.photos/990",
  //       description:
  //           "Quam pellentesque nec nam aliquam. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor."),
  //   PhotoModel(
  //       title: "Tortor aliquam",
  //       image: "https://picsum.photos/340",
  //       description:
  //           "Tortor aliquam nulla facilisi cras fermentum odio eu. Sagittis nisl rhoncus mattis rhoncus. Urna cursus eget nunc scelerisque. Id diam maecenas ultricies mi eget mauris pharetra et."),
  //   PhotoModel(
  //       title: "Nec ultrices",
  //       image: "https://picsum.photos/888",
  //       description:
  //           "Nec ultrices dui sapien eget mi proin sed. Purus in mollis nunc sed id semper risus in."),
  // ];

  void onSelect(BuildContext context, PhotoModel photo) {
    Navigator.pushNamed(
      context,
      AlbumDetailScreen.routeName,
      arguments: AlbumDetailScreenArgs(photo: photo),
    );
  }

  void onDownload(BuildContext context, PhotoModel photo) {
    downloadController.download(photo);
  }

  void initState() {
    albumController.fetchNext(pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Album"),
        ),
        body: GetBuilder<AlbumController>(
            initState: (state) => initState(),
            builder: (album) {
              if (album.photos.isEmpty) {
                return buildLoading(album);
              } else {
                return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.extentAfter == 0) {
                        album.fetchNext(pageSize: pageSize);
                        return true;
                      }
                      return false;
                    },
                    child: GetBuilder<PhotoDownloadController>(
                        builder: (downloader) =>
                            buildDetails(album, downloader)));
              }
            }));
  }

  Widget buildLoading(AlbumController album) =>
      Center(child: CircularProgressIndicator());

  Widget buildError(AlbumController album) =>
      Center(child: Text(album.lastError));

  Widget buildDetails(
          AlbumController album, PhotoDownloadController downloader) =>
      ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 2,
        ),
        itemCount: album.photos.length + 1,
        itemBuilder: (context, index) {
          if (index >= album.photos.length) {
            return Center(child: CircularProgressIndicator());
          }
          final item = album.photos[index];
          return AlbumListTile(
              item: item,
              onDownload: onDownload,
              onSelect: onSelect,
              downloadStatus: downloader.getStatus(item));
        },
      );
}
