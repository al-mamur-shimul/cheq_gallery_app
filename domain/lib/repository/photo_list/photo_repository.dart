import 'package:domain/domain.dart';

abstract class PhotoRepository {
  Future<Map<String, List<Photo>>> getPhotosGroupedByAlbums();
}
