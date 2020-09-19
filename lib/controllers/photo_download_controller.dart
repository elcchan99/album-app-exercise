import 'package:album_app/data/model/photo_model.dart';
import 'package:album_app/data/repository/local_photo_repository.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import 'gallery_controller.dart';

class PhotoDownloadController extends GetxController {
  final LocalPhotoRepository repository;

  PhotoDownloadController({@required this.repository})
      : assert(repository != null);

  Map<String, DownloadStatus> _statuses = {};
  Map<String, DownloadStatus> get statuses => _statuses;

  DownloadStatus getStatus(PhotoModel photo) {
    if (_statuses.containsKey(photo.image)) {
      return _statuses[photo.image];
    }
    return DownloadStatus.NOT_FOUND;
  }

  void setStatus(PhotoModel photo, DownloadStatus status) {
    _statuses[photo.image] = status;
    update();
  }

  void download(PhotoModel photo) async {
    final status = getStatus(photo);
    if ([DownloadStatus.NOT_FOUND, DownloadStatus.ERROR].contains(status)) {
      setStatus(photo, DownloadStatus.PENDING);
      await _downloadImage(photo)
          .then((_) => Get.find<GalleryController>().add(photo));
    }
  }

  Future<void> _downloadImage(PhotoModel photo) async {
    print("check permission");
    if (!(await Permission.storage.request()).isGranted) {
      setStatus(photo, DownloadStatus.ERROR);
      return;
    }
    print("permission granted");

    setStatus(photo, DownloadStatus.DOWNLOADING);
    print("Downloading image: ${photo.image}");

    await GallerySaver.saveImage("${photo.image}.jpg", albumName: "album_app")
        .then((value) {
          if (!value) {
            setStatus(photo, DownloadStatus.ERROR);
          } else {
            setStatus(photo, DownloadStatus.COMPLETED);
          }
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) => setStatus(photo, DownloadStatus.ERROR));
  }
}

enum DownloadStatus {
  PENDING,
  DOWNLOADING,
  COMPLETED,
  ERROR,
  NOT_FOUND,
}

extension PhotoDownloadExtension on PhotoModel {
  String get fileName {
    final name = this.title.toLowerCase().replaceAll(" ", "_");
    return "${name}_${this.id}.jpg";
  }
}
