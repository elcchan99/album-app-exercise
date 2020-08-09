import 'package:album_app/components/image_with_loading.dart';
import 'package:album_app/models/album_model.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({Key key}) : super(key: key);

  static final photos = <AlbumModel>[
    AlbumModel(
        title: "Viverra orci",
        image: "https://picsum.photos/456",
        description:
            "Ac tortor vitae purus faucibus ornare. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean."),
    AlbumModel(
        title: "Feugiat",
        image: "https://picsum.photos/1100",
        description:
            "Feugiat in fermentum posuere urna nec tincidunt praesent. Ac tortor vitae purus faucibus ornare. "),
    AlbumModel(
        title: "Mi bibendum",
        image: "https://picsum.photos/789",
        description:
            "Mi bibendum neque egestas congue quisque egestas diam in arcu. Ultricies tristique nulla aliquet enim tortor at auctor urna nunc."),
    AlbumModel(
        title: "Quam pellentesque",
        image: "https://picsum.photos/990",
        description:
            "Quam pellentesque nec nam aliquam. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor."),
    AlbumModel(
        title: "Tortor aliquam",
        image: "https://picsum.photos/340",
        description:
            "Tortor aliquam nulla facilisi cras fermentum odio eu. Sagittis nisl rhoncus mattis rhoncus. Urna cursus eget nunc scelerisque. Id diam maecenas ultricies mi eget mauris pharetra et."),
    AlbumModel(
        title: "Nec ultrices",
        image: "https://picsum.photos/888",
        description:
            "Nec ultrices dui sapien eget mi proin sed. Purus in mollis nunc sed id semper risus in."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Album"),
      ),
      body: Container(
          child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final item = photos[index];
          return ListTile(
            leading: SizedBox(
                width: 60,
                height: 60,
                child: ImageWithLoading(image: item.image)),
            title: Text(item.title),
            subtitle: Text(
              item.description,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      )),
    );
  }
}
