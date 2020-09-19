import 'package:get/get.dart';

import 'controllers/album_controller.dart';
import 'controllers/gallery_controller.dart';
import 'controllers/photo_download_controller.dart';
import 'data/provider/picsum_photo_api.dart';
import 'data/repository/local_photo_repository.dart';
import 'data/repository/photo_repository.dart';

class Bindings {
  final AlbumController albumController = Get.put<AlbumController>(
      AlbumController(
          repository: PhotoRepository(apiClient: PicsumPhotoApi())));

  final PhotoDownloadController downloadController =
      Get.put(PhotoDownloadController(repository: LocalPhotoRepository()));

  final GalleryController galleryController =
      Get.put(GalleryController(repository: LocalPhotoRepository()));
}
