// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data.dart' as _i633;
import '../data_source/photo_list/photo_data_source.dart' as _i35;
import '../data_source/photo_list/photo_data_source_impl.dart' as _i717;
import '../repository/photo_list/photo_repository_impl.dart' as _i552;

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
    gh.factory<_i35.PhotoDataSource>(() => _i717.PhotoDataSourceImpl());
    gh.factory<_i494.PhotoRepository>(() => _i552.PhotoRepositoryImpl(
        photoDataSource: gh<_i633.PhotoDataSource>()));
    return this;
  }
}
