import 'package:album_app/data/model/photo_model.dart';

class LocalPhotoRepository {
  List<PhotoModel> _photos = [];
  List<PhotoModel> get photos => _photos;

  List<PhotoModel> getAll() => photos;

  add(PhotoModel photo) {
    print("local add: $photo");
    _photos.add(photo);
    print("local: $photo");
  }

  remove(PhotoModel photo) {
    print("local remove: $photo");
    _photos.remove(photo);
    print("local: $photo");
  }
}
