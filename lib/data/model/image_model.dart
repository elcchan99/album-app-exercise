import 'dart:convert';

class ImageModel {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  ImageModel(this.id, this.author, this.width, this.height, this.url,
      this.downloadUrl);

  ImageModel copyWith({
    String id,
    String author,
    int width,
    int height,
    String url,
    String downloadUrl,
  }) {
    return ImageModel(
      id ?? this.id,
      author ?? this.author,
      width ?? this.width,
      height ?? this.height,
      url ?? this.url,
      downloadUrl ?? this.downloadUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'width': width,
      'height': height,
      'url': url,
      'download_url': downloadUrl,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImageModel(
      map['id'],
      map['author'],
      map['width'],
      map['height'],
      map['url'],
      map['download_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageModel(id: $id, author: $author, width: $width, height: $height, url: $url, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ImageModel &&
        o.id == id &&
        o.author == author &&
        o.width == width &&
        o.height == height &&
        o.url == url &&
        o.downloadUrl == downloadUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        width.hashCode ^
        height.hashCode ^
        url.hashCode ^
        downloadUrl.hashCode;
  }
}
