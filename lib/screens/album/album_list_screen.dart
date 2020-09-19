import 'package:album_app/controllers/album_controller.dart';
import 'package:album_app/controllers/photo_download_controller.dart';
import 'package:album_app/data/model/photo_model.dart';
import 'package:album_app/screens/album/album_detail_screen.dart';
import 'package:album_app/screens/album/components/album_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumListScreen extends StatelessWidget {
  static const String routeName = "/ablum";

  final AlbumController albumController = Get.find<AlbumController>();
  final PhotoDownloadController downloadController =
      Get.find<PhotoDownloadController>();

  static const int pageSize = 12;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Album"),
        ),
        body: GetBuilder<AlbumController>(initState: (state) {
          albumController.fetchNext(pageSize: pageSize);
        }, builder: (album) {
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
                    builder: (downloader) => buildDetails(album, downloader)));
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
