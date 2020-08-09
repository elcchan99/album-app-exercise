import 'package:album_app/components/image_with_loading.dart';
import 'package:album_app/models/photo_model.dart';
import 'package:album_app/screens/album/album_detail_screen.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatelessWidget {
  static const String routeName = "/ablum";

  static final photos = <PhotoModel>[
    PhotoModel(
        title: "Viverra orci",
        image: "https://picsum.photos/456",
        description:
            "Ac tortor vitae purus faucibus ornare. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean."),
    PhotoModel(
        title: "Feugiat",
        image: "https://picsum.photos/1100",
        description:
            "Feugiat in fermentum posuere urna nec tincidunt praesent. Ac tortor vitae purus faucibus ornare. "),
    PhotoModel(
        title: "Mi bibendum",
        image: "https://picsum.photos/789",
        description:
            "Mi bibendum neque egestas congue quisque egestas diam in arcu. Ultricies tristique nulla aliquet enim tortor at auctor urna nunc."),
    PhotoModel(
        title: "Quam pellentesque",
        image: "https://picsum.photos/990",
        description:
            "Quam pellentesque nec nam aliquam. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor."),
    PhotoModel(
        title: "Tortor aliquam",
        image: "https://picsum.photos/340",
        description:
            "Tortor aliquam nulla facilisi cras fermentum odio eu. Sagittis nisl rhoncus mattis rhoncus. Urna cursus eget nunc scelerisque. Id diam maecenas ultricies mi eget mauris pharetra et."),
    PhotoModel(
        title: "Nec ultrices",
        image: "https://picsum.photos/888",
        description:
            "Nec ultrices dui sapien eget mi proin sed. Purus in mollis nunc sed id semper risus in."),
  ];

  void onSelect(BuildContext context, int index) {
    Navigator.pushNamed(
      context,
      AlbumDetailScreen.routeName,
      arguments: AlbumDetailScreenArgs(photo: photos[index]),
    );
  }

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
                width: 70,
                height: 70,
                child: Hero(
                  child: ImageWithLoading(image: item.image),
                  tag: item.image,
                )),
            title: Text(item.title),
            subtitle: Text(
              item.description,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              onSelect(context, index);
            },
          );
        },
      )),
    );
  }
}
