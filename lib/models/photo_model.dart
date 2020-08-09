class PhotoModel {
  final String title;
  final String description;
  final String image;

  PhotoModel({this.title, this.description, this.image});

  @override
  String toString() =>
      'PhotoModel(title: $title, description: $description, image: $image)';
}
