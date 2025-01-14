import 'package:cheq_gallery_app/permission/permission.dart';
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
        child: StoragePermissionNotFoundWidget(),
      ),
    );
  }
}
