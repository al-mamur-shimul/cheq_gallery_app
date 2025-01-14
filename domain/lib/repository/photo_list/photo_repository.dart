import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class PhotoRepository {
  Future<Either<Map<String, List<Photo>>, String>> getPhotosGroupedByAlbums();
}
