import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({
    required this.data,
    super.key,
  });

  final MapEntry<String, List<String>> data;

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  bool isPhotoPreviewDialogVisible = false;

  @override
  void initState() {
    super.initState();
  }

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
          return _buildPhotoListItem(context, widget.data.value[index]);
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
        child: Container(
          height: 85,
          width: 85,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _onPhotoItemTap(BuildContext context, String imagePath) {
    isPhotoPreviewDialogVisible = true;
    _updateStatusBar();
    _showPhotoPreviewDialog(context, imagePath);
  }

  void _showPhotoPreviewDialog(BuildContext context, String imagePath) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: _buildDialogBody(imagePath, context),
        );
      },
    );
  }

  Container _buildDialogBody(String imagePath, BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.fitWidth,
          ),
          _buildCloseButton(context),
        ],
      ),
    );
  }

  Positioned _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          isPhotoPreviewDialogVisible = false;
          _updateStatusBar();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _updateStatusBar() {
    if (isPhotoPreviewDialogVisible) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }
}
