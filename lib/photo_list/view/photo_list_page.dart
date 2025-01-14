import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cheq_gallery_app/photo_preview/photo_preview.dart';
import 'package:domain/entity/photo_list/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({
    required this.data,
    super.key,
  });

  final MapEntry<String, List<Photo>> data;
  static const path = '/photos';

  static Route<void> route(MapEntry<String, List<Photo>> data) {
    return MaterialPageRoute<void>(
      builder: (_) => PhotoListPage(data: data),
    );
  }

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.data.key),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhotoGridView(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoGridView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemCount: widget.data.value.length,
        // Example item count
        itemBuilder: (context, index) {
          return _buildPhotoListItem(context, widget.data.value[index].path);
        },
      ),
    );
  }

  Widget _buildPhotoListItem(BuildContext context, String imagePath) {
    return InkWell(
      onTap: () {
        _onPhotoItemTap(context, imagePath);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 85,
          width: 85,
          child: FutureBuilder<Uint8List>(
            future: _generateThumbnail(imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                );
              } else {
                return _buildLoadingPlaceholder();
              }
            },
          ),
        ),
      ),
    );
  }

  Center _buildLoadingPlaceholder() {
    return Center(
      child: Icon(
        Icons.image,
        size: 32,
        color: Colors.blueGrey.shade400,
      ),
    );
  }

  void _onPhotoItemTap(BuildContext context, String imagePath) {
    Navigator.push(context, PhotoPreviewPage.route(imagePath));
  }

  Future<Uint8List> _generateThumbnail(String imagePath) async {
    final image = ResizeImage(
      FileImage(File(imagePath)),
      width: 85,
      height: 85,
    );
    final completer = Completer<ui.Image>();
    image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );
    final uiImage = await completer.future;
    final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
