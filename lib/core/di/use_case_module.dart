import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case/use_cases.dart';
import 'package:injectable/injectable.dart';

@module
abstract class UseCaseModule {
  @singleton
  DataLayer provideDataLayer(PhotoDataSource photoDataSource) {
    return DataLayerImpl();
  }

  @singleton
  FetchPhotosGroupedByAlbumsUseCase fetchPhotosGroupedByAlbumsUseCase(
    DataLayer dataLayer,
  ) {
    return FetchPhotosGroupedByAlbumsUseCase(dataLayer.createRepository());
  }
}
