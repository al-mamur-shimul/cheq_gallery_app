import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PhotoRepository)
class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDataSource photoDataSource;

  PhotoRepositoryImpl({required this.photoDataSource});

  @override
  Future<Either<Map<String, List<Photo>>, String>>
      getPhotosGroupedByAlbums() async {
    try {
      final rawData = await photoDataSource.fetchDeviceImages();
      final result = <String, List<Photo>>{};
      rawData.forEach((key, value) {
        final photoList = <Photo>[];
        for (final element in value) {
          photoList.add(Photo(element));
        }
        result[key] = photoList;
      });

      return Left(result);
    } catch (e) {
      return Right('Error fetching photos ${e.toString()}');
    }
  }
}
