import 'package:cheq_gallery_app/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

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
        title: const Text('Album Name'),
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
        itemCount: 20,
        // Example item count
        itemBuilder: (context, index) {
          return _buildPhotoListItem(context);
        },
      ),
    );
  }

  Widget _buildPhotoListItem(BuildContext context) {
    return InkWell(
      onTap: () {
        isPhotoPreviewDialogVisible = true;
        _updateStatusBar();
        _showPhotoPreviewDialog(context);
      },
      child: Container(
        height: 85,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPaths.people),
          ),
        ),
      ),
    );
  }

  void _showPhotoPreviewDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AssetPaths.chair,
                  fit: BoxFit.fitWidth,
                ),
                _buildCloseButton(context),
              ],
            ),
          ),
        );
      },
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
