import 'package:cheq_gallery_app/albums_list/view/album_list_page.dart';
import 'package:cheq_gallery_app/core/di/app_layer_config.dart';
import 'package:cheq_gallery_app/permission/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoragePermissionCheckingPage extends StatefulWidget {
  const StoragePermissionCheckingPage({super.key});

  @override
  State<StoragePermissionCheckingPage> createState() =>
      _StoragePermissionCheckingPageState();
}

class _StoragePermissionCheckingPageState
    extends State<StoragePermissionCheckingPage> {
  late StoragePermissionCubit storagePermissionCubit;

  @override
  void initState() {
    super.initState();
    storagePermissionCubit = sl.get<StoragePermissionCubit>()
      ..requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<StoragePermissionCubit, StoragePermissionState>(
          listener: _onStoragePermissionChanged,
          bloc: storagePermissionCubit,
          builder: (context, state) {
            if (state is StoragePermissionDenied) {
              return StoragePermissionNotFoundWidget(
                onTap: () => storagePermissionCubit.requestPermission(),
              );
            } else if (state is StoragePermissionPermanentlyDenied) {
              return const Center(
                child: Text(
                  'Permission permanently denied, please grant it from settings',
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _onStoragePermissionChanged(
    BuildContext context,
    StoragePermissionState state,
  ) {
    if (state is StoragePermissionGranted) {
      Navigator.push(
        context,
        AlbumListPage.route(),
      );
    }
  }
}
