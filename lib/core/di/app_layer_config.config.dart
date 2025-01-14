// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/data.dart' as _i437;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../albums_list/cubit/fetch_photo_album_cubit.dart' as _i188;
import 'use_case_module.dart' as _i1054;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final useCaseModule = _$UseCaseModule();
    gh.singleton<_i437.DataLayer>(
        () => useCaseModule.provideDataLayer(gh<_i437.PhotoDataSource>()));
    gh.singleton<_i494.FetchPhotosGroupedByAlbumsUseCase>(() =>
        useCaseModule.fetchPhotosGroupedByAlbumsUseCase(gh<_i437.DataLayer>()));
    gh.factory<_i188.FetchPhotoAlbumCubit>(() => _i188.FetchPhotoAlbumCubit(
        gh<_i494.FetchPhotosGroupedByAlbumsUseCase>()));
    return this;
  }
}

class _$UseCaseModule extends _i1054.UseCaseModule {}
