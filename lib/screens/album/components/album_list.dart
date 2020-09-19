import 'package:album_app/controllers/album_controller.dart';
import 'package:album_app/controllers/photo_download_controller.dart';
import 'package:album_app/data/model/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'album_list_tile.dart';

class AlbumList extends StatelessWidget {
  final AlbumController albumController;
  final int pageSize;
  final Function(BuildContext, PhotoModel) onSelect;
  final Function(BuildContext, PhotoModel) onDownload;

  AlbumList(
      {Key key,
      @required this.albumController,
      @required this.pageSize,
      this.onSelect,
      this.onDownload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (albumController.photos.isEmpty) {
      return buildLoading(albumController);
    }

    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              scrollInfo.metrics.extentAfter == 0) {
            albumController.fetchNext(pageSize: pageSize);
            return true;
          }
          return false;
        },
        child: GetBuilder<PhotoDownloadController>(
            builder: (downloader) =>
                buildDetails(albumController, downloader)));
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
              onDownload: this.onDownload,
              onSelect: this.onSelect,
              downloadStatus: downloader.getStatus(item));
        },
      );
}
