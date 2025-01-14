import 'package:cheq_gallery_app/common/asset_paths.dart';
import 'package:cheq_gallery_app/common/colors.dart';
import 'package:flutter/material.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

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
        itemBuilder: (context, index) {
          return _buildAlbumGridItem();
        },
      ),
    );
  }

  ClipRRect _buildAlbumGridItem() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(AssetPaths.people),
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
            _buildAlbumDetails(),
          ],
        ),
      ),
    );
  }

  Positioned _buildAlbumDetails() {
    return const Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Album Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '10 Photos',
              style: TextStyle(
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
