import 'package:album_app/data/model/photo_model.dart';
import 'package:album_app/data/repository/local_photo_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final LocalPhotoRepository repository;
  GalleryController({@required this.repository}) : assert(repository != null);

  final _photos = List<PhotoModel>().obs;
  List<PhotoModel> get photos => this._photos.value;
  set photos(value) => _photos.value = value;

  void init() {
    print("gallery init");
    dynamic a = repository.getAll();
    print("repo: $a");
    photos = a;
  }

  void refresh() {
    init();
  }

  void add(PhotoModel photo) {
    print("GalleryController.add()");
    repository.add(photo);
  }

  void delete(PhotoModel photo) {
    print("GalleryController.remove()");
    repository.remove(photo);
  }
}
