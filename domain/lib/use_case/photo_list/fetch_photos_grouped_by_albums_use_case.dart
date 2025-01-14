import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class FetchPhotosGroupedByAlbumsUseCase {
  final PhotoRepository _photoRepository;

  const FetchPhotosGroupedByAlbumsUseCase(this._photoRepository);

  Future<Either<Map<String, List<Photo>>, String>> call() async {
    return _photoRepository.getPhotosGroupedByAlbums();
  }
}
