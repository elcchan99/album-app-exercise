import 'package:album_app/data/provider/picsum_photo_api.dart';
import 'package:flutter/material.dart';

class PhotoRepository {
  final PicsumPhotoApi apiClient;

  PhotoRepository({@required this.apiClient}) : assert(apiClient != null);

  list({int pageSize = 10, int offset = 0}) {
    return apiClient.list(pageSize: pageSize, offset: offset);
  }
}
