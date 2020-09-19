import 'package:album_app/components/image_with_loading.dart';
import 'package:album_app/controllers/photo_download_controller.dart';
import 'package:album_app/data/model/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../constant.dart';

class AlbumListTile extends StatelessWidget {
  final PhotoModel item;
  final Function(BuildContext, PhotoModel) onSelect;
  final Function(BuildContext, PhotoModel) onDownload;
  final DownloadStatus downloadStatus;

  const AlbumListTile(
      {Key key, this.item, this.onSelect, this.onDownload, this.downloadStatus})
      : super(key: key);

  bool _isDownloading() {
    return [DownloadStatus.PENDING, DownloadStatus.DOWNLOADING]
        .contains(downloadStatus);
  }

  bool _isDownloaded() {
    return downloadStatus == DownloadStatus.COMPLETED;
  }

  bool _isDownloadError() {
    return downloadStatus == DownloadStatus.ERROR;
  }

  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SizedBox(
                width: 70,
                height: 70,
                child: Stack(children: [
                  Hero(
                    child: ImageWithLoading(
                        image: item.imageUrlWithFixedSize(70, 70)),
                    tag: item.image,
                  ),
                  buildDownloadProgressIcon(context),
                ])),
            title: Text(item.title),
            subtitle: Text(
              item.description,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              onSelect(context, item);
            },
          )),
      secondaryActions: buildActions(context),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    List<Widget> actions = [];
    if (_isDownloaded()) {
      return actions;
    }
    if (_isDownloading()) {
      actions.add(buildDownloadingbutton(context));
    } else {
      actions.add(buildDownloadButton(context));
    }
    return actions;
  }

  Widget buildDownloadingbutton(BuildContext context) {
    return IconSlideAction(
      caption: "Downloading...",
      color: kTertiaryColor,
      icon: Icons.pause,
      // TODO: onTap: () => onCancelDownload(context, item),
    );
  }

  Widget buildDownloadButton(BuildContext context) {
    return IconSlideAction(
      caption: "Download",
      color: kQuaternaryColor,
      icon: Icons.file_download,
      onTap: () => onDownload(context, item),
    );
  }

  Widget buildDownloadProgressIcon(BuildContext context) {
    if (_isDownloading()) {
      return Positioned(
          bottom: 4,
          right: 12, // ListTile.leading has auto horizontal padding
          child: SizedBox(
            height: 12,
            width: 12,
            child: CircularProgressIndicator(),
          ));
    } else if (_isDownloaded()) {
      return Positioned(
        bottom: 2,
        right: 7, // ListTile.leading has auto horizontal padding
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        ),
      );
    } else if (_isDownloadError()) {
      return Positioned(
        bottom: 2,
        right: 7, // ListTile.leading has auto horizontal padding
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: 20,
        ),
      );
    }
    return Container();
  }
}
