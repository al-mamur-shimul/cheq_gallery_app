import 'package:cheq_gallery_app/common/asset_paths.dart';
import 'package:cheq_gallery_app/common/colors.dart';
import 'package:flutter/material.dart';

class StoragePermissionCheckingPage extends StatefulWidget {
  const StoragePermissionCheckingPage({super.key});

  @override
  State<StoragePermissionCheckingPage> createState() =>
      _StoragePermissionCheckingPageState();
}

class _StoragePermissionCheckingPageState
    extends State<StoragePermissionCheckingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetPaths.permissionRequired,
                width: 123,
                height: 149,
              ),
              const SizedBox(height: 42),
              Text(
                'Permission Required',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mediumHeadingColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 53),
                child: Text('To show your black and white photos we just need your folder permission. We promise, we don’t take your photos.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.smallBodyTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 42),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // Full width
                    backgroundColor: const Color(0xFF66FFB6), // Background color
                  ),
                  child: const Text(
                    'Grant Access',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
