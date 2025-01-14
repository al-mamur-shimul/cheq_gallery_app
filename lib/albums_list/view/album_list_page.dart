import 'dart:io';

import 'package:cheq_gallery_app/common/colors.dart';
import 'package:cheq_gallery_app/common/gallery_images.dart';
import 'package:cheq_gallery_app/photo_list/view/photo_list_page.dart';
import 'package:flutter/material.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key});

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  Map<String, List<String>> deviceImagesGroupedByAlbum = {};

  @override
  void initState() {
    super.initState();
    _fetchDeviceImages();
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
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: deviceImagesGroupedByAlbum.length,
        itemBuilder: (context, index) {
          return _buildAlbumGridItem(
            context,
            deviceImagesGroupedByAlbum.entries.elementAt(index),
          );
        },
      ),
    );
  }

  Widget _buildAlbumGridItem(
    BuildContext context,
    MapEntry<String, List<String>> album,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) =>  PhotoListPage(
              data: album,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File(album.value.first)),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
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

  Future<void> _fetchDeviceImages() async {
    deviceImagesGroupedByAlbum = await GalleryImages.fetchDeviceImages();
    setState(() {});
  }
}
