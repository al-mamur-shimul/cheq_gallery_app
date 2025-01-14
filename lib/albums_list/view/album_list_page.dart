import 'dart:io';

import 'package:cheq_gallery_app/albums_list/cubit/fetch_photo_album_cubit.dart';
import 'package:cheq_gallery_app/common/colors.dart';
import 'package:cheq_gallery_app/core/di/app_layer_config.dart';
import 'package:cheq_gallery_app/photo_list/view/photo_list_page.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key});

  static const path = '/albums';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AlbumListPage(),
    );
  }

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  late FetchPhotoAlbumCubit fetchPhotoAlbumCubit;

  @override
  void initState() {
    super.initState();
    fetchPhotoAlbumCubit = sl.get<FetchPhotoAlbumCubit>();
    fetchPhotoAlbumCubit.fetchPhotosGroupedByAlbums();
  }

  @override
  void dispose() {
    fetchPhotoAlbumCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadingText(),
              _buildAlbumGridView(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildAlbumGridView() {
    return Expanded(
      child: BlocBuilder<FetchPhotoAlbumCubit, FetchPhotoAlbumState>(
        bloc: fetchPhotoAlbumCubit,
        builder: (context, state) {
          if (state is FetchPhotoAlbumInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchPhotoAlbumFailure) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is FetchPhotoAlbumSuccess) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.photosGroupedByAlbums.length,
              itemBuilder: (context, index) {
                return _buildAlbumGridItem(
                  context,
                  state.photosGroupedByAlbums.entries.elementAt(index),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildAlbumGridItem(
    BuildContext context,
    MapEntry<String, List<Photo>> album,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PhotoListPage.route(album),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File(album.value.first.path)),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
              ),
              _buildAlbumDetails(album.key, album.value.length),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildAlbumDetails(String name, int photoCount) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '$photoCount Photos',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildHeadingText() {
    return Text(
      'Albums',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: AppColors.largeHeadingTextColor,
      ),
    );
  }
}
