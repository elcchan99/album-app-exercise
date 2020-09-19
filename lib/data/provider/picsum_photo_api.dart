import 'dart:io';

import 'package:album_app/data/model/image_model.dart';
import 'package:dio/dio.dart';

class PicsumPhotoApi {
  static const baseUrl = "https://picsum.photos";

  Future<List<ImageModel>> list({int pageSize = 10, int offset = 0}) async {
    Response response = await Dio().get("$baseUrl/v2/list", queryParameters: {
      "page": offset,
      "limit": pageSize,
    });
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error: HTTP[${response.statusCode}] ${response.data}');
    }
    return (response.data as List).map((e) => ImageModel.fromMap(e)).toList();
  }
}
