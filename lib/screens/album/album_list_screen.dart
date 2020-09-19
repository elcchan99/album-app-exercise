import 'package:album_app/controllers/album_controller.dart';
import 'package:album_app/controllers/gallery_controller.dart';
import 'package:album_app/controllers/photo_download_controller.dart';
import 'package:album_app/data/model/photo_model.dart';
import 'package:album_app/screens/album/album_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/album_gallery.dart';
import 'components/album_list.dart';

class AlbumListScreen extends StatefulWidget {
  static const String routeName = "/ablum";

  static const int pageSize = 12;

  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  final AlbumController albumController = Get.find<AlbumController>();

  final PhotoDownloadController downloadController =
      Get.find<PhotoDownloadController>();

  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onSelect(BuildContext context, PhotoModel photo) {
    Navigator.pushNamed(
      context,
      AlbumDetailScreen.routeName,
      arguments: AlbumDetailScreenArgs(photo: photo),
    );
  }

  void onDownload(BuildContext context, PhotoModel photo) {
    downloadController.download(photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Album"),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [
          GetBuilder<AlbumController>(
            initState: (state) {
              albumController.fetchNext(pageSize: AlbumListScreen.pageSize);
            },
            builder: (album) => AlbumList(
              albumController: album,
              pageSize: AlbumListScreen.pageSize,
              onSelect: onSelect,
              onDownload: onDownload,
            ),
          ),
          AlbumGallery(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            _pageController.animateToPage(value,
                duration: Duration(milliseconds: 200), curve: Curves.easeOut);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            activeIcon: Icon(Icons.collections),
            title: Text("Picsum photos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            activeIcon: Icon(Icons.dashboard),
            title: Text("Gallery"),
          ),
        ],
      ),
    );
  }
}
