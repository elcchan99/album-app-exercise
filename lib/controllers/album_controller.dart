import 'dart:io';

import 'package:album_app/data/model/image_model.dart';
import 'package:album_app/data/model/photo_model.dart';
import 'package:album_app/data/repository/photo_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AlbumController extends GetxController {
  final PhotoRepository repository;
  AlbumController({@required this.repository}) : assert(repository != null);

  List<PhotoModel> _photos = <PhotoModel>[];
  List<PhotoModel> get photos => this._photos;

  ProgressStatus _progressStatus = ProgressStatus.IDLE;
  ProgressStatus get progressStatus => _progressStatus;

  int _piscumOffset = 0;
  String _lastError;
  String get lastError => _lastError;
  bool get isError => _lastError?.isNotEmpty ?? false;

  void fetchNext({int pageSize = 10}) async {
    if (_progressStatus == ProgressStatus.LOADING) {
      print("Duplicate fetchNext request");
      return;
    }
    _startProgress();
    await repository
        .list(pageSize: pageSize, offset: _piscumOffset)
        .catchError(_handleError)
        .then((List<ImageModel> images) => images.forEach((e) {
              this._photos.add(PhotoModel.fromImageModel(e));
              _piscumOffset += 1;
            }))
        .whenComplete(_completeProgress);
  }

  void _startProgress() {
    _progressStatus = ProgressStatus.LOADING;
    update();
  }

  void _completeProgress() {
    _progressStatus = ProgressStatus.IDLE;
    _lastError = null;
    update();
  }

  void _handleError(Object error) {
    _progressStatus = ProgressStatus.ERROR;
    _lastError = error.toString();
    update();
  }
}

enum ProgressStatus {
  LOADING,
  IDLE,
  ERROR,
}
