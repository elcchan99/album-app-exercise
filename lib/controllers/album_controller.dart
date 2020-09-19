import 'dart:io';

import 'package:album_app/data/models/image_model.dart';
import 'package:album_app/data/models/photo_model.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';

class AlbumController extends GetxController {
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
    _callFetchNextApi(pageSize: pageSize, offset: _piscumOffset)
        .catchError(_handleError)
        .then((jsonList) => jsonList
            .map((e) => ImageModel.fromMap(e))
            .map((e) => PhotoModel.fromImageModel(e))
            .toList())
        .then((images) {
      _piscumOffset += images.length;
      _photos.addAll(images);
    }).whenComplete(() {
      _completeProgress();
    });
  }

  Future<List<dynamic>> _callFetchNextApi(
      {int pageSize = 10, int offset = 0}) async {
    Response response =
        await Dio().get("https://picsum.photos/v2/list", queryParameters: {
      "page": offset,
      "limit": pageSize,
    });
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error: HTTP[${response.statusCode}] ${response.data}');
    }
    return response.data as List;
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
