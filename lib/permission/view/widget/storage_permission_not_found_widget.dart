import 'dart:async';

import 'package:cheq_gallery_app/albums_list/view/album_list_page.dart';
import 'package:cheq_gallery_app/common/asset_paths.dart';
import 'package:cheq_gallery_app/common/colors.dart';
import 'package:cheq_gallery_app/permission/permission.dart';
import 'package:flutter/material.dart';

class StoragePermissionNotFoundWidget extends StatefulWidget {
  const StoragePermissionNotFoundWidget({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  State<StoragePermissionNotFoundWidget> createState() =>
      _StoragePermissionNotFoundWidgetState();
}

class _StoragePermissionNotFoundWidgetState
    extends State<StoragePermissionNotFoundWidget> {
  void _onPermissionStatusChanged(StoragePermissionState state) {
    if (state is StoragePermissionGranted) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const AlbumListPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPermissionGrantedImage(),
          const SizedBox(height: 42),
          _buildHeaderText(),
          const SizedBox(height: 8),
          _buildSubtitleText(),
          const SizedBox(height: 42),
          CustomButtonWidget(
            text: 'Grant Access',
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }

  Image _buildPermissionGrantedImage() {
    return Image.asset(
      AssetPaths.permissionRequired,
      width: 123,
      height: 149,
      fit: BoxFit.fill,
    );
  }

  Text _buildHeaderText() {
    return Text(
      'Permission Required',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.mediumHeadingColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitleText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 53),
      child: Text(
        'To show your black and white photos we just need your folder permission. We promise, we don’t take your photos.',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.smallBodyTextColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
