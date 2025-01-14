import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'fetch_photo_album_state.dart';

@injectable
class FetchPhotoAlbumCubit extends Cubit<FetchPhotoAlbumState> {
  FetchPhotoAlbumCubit(this.useCase) : super(FetchPhotoAlbumInitial());

  final FetchPhotosGroupedByAlbumsUseCase useCase;

  Future<void> fetchPhotosGroupedByAlbums() async {
    emit(FetchPhotoAlbumInProgress());
    final result = await useCase();
    result.fold(
      (photosGroupedByAlbums) => emit(
        FetchPhotoAlbumSuccess(photosGroupedByAlbums),
      ),
      (error) => emit(FetchPhotoAlbumFailure(error)),
    );
  }
}
