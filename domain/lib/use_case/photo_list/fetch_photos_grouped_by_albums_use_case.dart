import 'package:domain/domain.dart';

class FetchPhotosGroupedByAlbumsUseCase {
  final PhotoRepository _photoRepository;

  const FetchPhotosGroupedByAlbumsUseCase(this._photoRepository);

  Future<Map<String, List<Photo>>> call() async {
    return _photoRepository.getPhotosGroupedByAlbums();
  }
}
