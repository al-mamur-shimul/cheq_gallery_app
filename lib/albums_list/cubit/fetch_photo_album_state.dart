part of 'fetch_photo_album_cubit.dart';

sealed class FetchPhotoAlbumState extends Equatable {
  const FetchPhotoAlbumState();
}

final class FetchPhotoAlbumInitial extends FetchPhotoAlbumState {
  @override
  List<Object> get props => [];
}

final class FetchPhotoAlbumInProgress extends FetchPhotoAlbumState {
  @override
  List<Object> get props => [];
}

final class FetchPhotoAlbumSuccess extends FetchPhotoAlbumState {
  const FetchPhotoAlbumSuccess(this.photosGroupedByAlbums);

  final Map<String, List<Photo>> photosGroupedByAlbums;

  @override
  List<Object> get props => [photosGroupedByAlbums];
}

final class FetchPhotoAlbumFailure extends FetchPhotoAlbumState {
  const FetchPhotoAlbumFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
