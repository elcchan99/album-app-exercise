import 'dart:math';

import 'package:album_app/models/image_model.dart';
import 'package:english_words/english_words.dart';

class PhotoModel {
  final String title;
  final String description;
  final String image;
  final String id;
  final int width;
  final int height;

  PhotoModel(
      {this.title,
      this.description,
      this.image,
      this.id,
      this.height,
      this.width});

  factory PhotoModel.fromImageModel(ImageModel imageModel) {
    return PhotoModel(
      title: _randomTitle(),
      description: "Author: ${imageModel.author}\n" + _randomDescription(),
      image: imageModel.downloadUrl,
      id: imageModel.id,
      height: imageModel.height,
      width: imageModel.width,
    );
  }

  @override
  String toString() =>
      'PhotoModel(title: $title, description: $description, image: $image, id: $id)';

  static String _randomTitle() =>
      generateWordPairs().take(Random().nextInt(3) + 2).join(" ");

  static String _randomDescription() =>
      generateWordPairs().take(Random().nextInt(5) + 8).join(" ");

  String imageUrlWithFixedSize(int height, int width) {
    return "https://picsum.photos/id/${id}/$width/$height";
  }
}
