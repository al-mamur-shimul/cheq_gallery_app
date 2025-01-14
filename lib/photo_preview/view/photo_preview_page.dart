import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class PhotoPreviewPage extends StatelessWidget {
  const PhotoPreviewPage({required this.filePath, super.key});

  final String filePath;
  static const path = '/photo-preview';

  static Route<void> route(String filePath) {
    return MaterialPageRoute<void>(
      builder: (_) => PhotoPreviewPage(filePath: filePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox.expand(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildImageView(),
                _buildCloseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageView() {
    return ZoomOverlay(
      minScale: 0.5,
      maxScale: 3,
      animationDuration: const Duration(milliseconds: 300),
      twoTouchOnly: true,
      child: SizedBox(
        child: Image.file(
          File(filePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 14,
      left: 14,
      child: InkWell(
        child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
