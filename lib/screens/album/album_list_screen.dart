import 'package:album_app/components/image_with_loading.dart';
import 'package:album_app/constant.dart';
import 'package:album_app/controllers/album_controller.dart';
import 'package:album_app/models/photo_model.dart';
import 'package:album_app/screens/album/album_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class AlbumListScreen extends StatelessWidget {
  static const String routeName = "/ablum";

  final AlbumController albumController = Get.put(AlbumController());

  static const int pageSize = 12;

  // static final photos = <PhotoModel>[
  //   PhotoModel(
  //       title: "Viverra orci",
  //       image: "https://picsum.photos/456",
  //       description:
  //           "Ac tortor vitae purus faucibus ornare. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean."),
  //   PhotoModel(
  //       title: "Feugiat",
  //       image: "https://picsum.photos/1100",
  //       description:
  //           "Feugiat in fermentum posuere urna nec tincidunt praesent. Ac tortor vitae purus faucibus ornare. "),
  //   PhotoModel(
  //       title: "Mi bibendum",
  //       image: "https://picsum.photos/789",
  //       description:
  //           "Mi bibendum neque egestas congue quisque egestas diam in arcu. Ultricies tristique nulla aliquet enim tortor at auctor urna nunc."),
  //   PhotoModel(
  //       title: "Quam pellentesque",
  //       image: "https://picsum.photos/990",
  //       description:
  //           "Quam pellentesque nec nam aliquam. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor."),
  //   PhotoModel(
  //       title: "Tortor aliquam",
  //       image: "https://picsum.photos/340",
  //       description:
  //           "Tortor aliquam nulla facilisi cras fermentum odio eu. Sagittis nisl rhoncus mattis rhoncus. Urna cursus eget nunc scelerisque. Id diam maecenas ultricies mi eget mauris pharetra et."),
  //   PhotoModel(
  //       title: "Nec ultrices",
  //       image: "https://picsum.photos/888",
  //       description:
  //           "Nec ultrices dui sapien eget mi proin sed. Purus in mollis nunc sed id semper risus in."),
  // ];

  void onSelect(BuildContext context, PhotoModel photo) {
    Navigator.pushNamed(
      context,
      AlbumDetailScreen.routeName,
      arguments: AlbumDetailScreenArgs(photo: photo),
    );
  }

  void onDownload(PhotoModel photo) {
    print("Going to download $photo");
  }

  void initState() {
    albumController.fetchNext(pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Album"),
        ),
        body: GetBuilder<AlbumController>(
            initState: (state) => initState(),
            builder: (album) {
              if (album.photos.isEmpty) {
                return buildLoading(album);
              } else {
                return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.extentAfter == 0) {
                        album.fetchNext(pageSize: pageSize);
                        return true;
                      }
                      return false;
                    },
                    child: buildDetails(album));
              }
            }));
  }

  Widget buildLoading(AlbumController album) =>
      Center(child: CircularProgressIndicator());

  Widget buildError(AlbumController album) =>
      Center(child: Text(album.lastError));

  Widget buildDetails(AlbumController album) => ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 2,
        ),
        itemCount: album.photos.length + 1,
        itemBuilder: (context, index) {
          if (index >= album.photos.length) {
            return Center(child: CircularProgressIndicator());
          }
          final item = album.photos[index];
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: SizedBox(
                      width: 70,
                      height: 70,
                      child: Hero(
                        child: ImageWithLoading(
                            image: item.imageUrlWithFixedSize(70, 70)),
                        tag: item.image,
                      )),
                  title: Text(item.title),
                  subtitle: Text(
                    item.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    onSelect(context, item);
                  },
                )),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: "Download",
                color: kQuaternaryColor,
                icon: Icons.file_download,
                onTap: () => onDownload(item),
              ),
            ],
          );
        },
      );
}
