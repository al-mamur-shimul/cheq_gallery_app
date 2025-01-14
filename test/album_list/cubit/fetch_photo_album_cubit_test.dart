

import 'package:bloc_test/bloc_test.dart';
import 'package:cheq_gallery_app/albums_list/cubit/fetch_photo_album_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchPhotoAlbumUseCase extends Mock
    implements FetchPhotosGroupedByAlbumsUseCase {}

void main() {
  group('FetchPhotoAlbumCubit', () {
    late FetchPhotoAlbumCubit fetchPhotoAlbumCubit;
    late MockFetchPhotoAlbumUseCase mockFetchPhotoAlbumUseCase;

    setUp(() {
      mockFetchPhotoAlbumUseCase = MockFetchPhotoAlbumUseCase();
      fetchPhotoAlbumCubit = FetchPhotoAlbumCubit(mockFetchPhotoAlbumUseCase);
    });

    test('initial state is FetchPhotoAlbumInitial', () {
      expect(fetchPhotoAlbumCubit.state, FetchPhotoAlbumInitial());
    });

    blocTest<FetchPhotoAlbumCubit, FetchPhotoAlbumState>(
      '''emits [FetchPhotoAlbumInProgress, FetchPhotoAlbumSuccess] when fetch is successful''',
      build: () {
        when(() => mockFetchPhotoAlbumUseCase.call()).thenAnswer(
          (_) async => const Left({}),
        );
        return fetchPhotoAlbumCubit;
      },
      act: (cubit) => cubit.fetchPhotosGroupedByAlbums(),
      expect: () => [
        FetchPhotoAlbumInProgress(),
        const FetchPhotoAlbumSuccess({}),
      ],
    );

    blocTest<FetchPhotoAlbumCubit, FetchPhotoAlbumState>(
      'emits [FetchPhotoAlbumInProgress, FetchPhotoAlbumFailure] when fetch fails',
      build: () {
        when(() => mockFetchPhotoAlbumUseCase.call()).thenAnswer(
          (_) async => const Right('Failed to fetch'),
        );
        return fetchPhotoAlbumCubit;
      },
      act: (cubit) => cubit.fetchPhotosGroupedByAlbums(),
      expect: () => [
        FetchPhotoAlbumInProgress(),
        const FetchPhotoAlbumFailure('Failed to fetch'),
      ],
    );
  });
}
