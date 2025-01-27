import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cheq_gallery_app/permission/cubit/storage_permission_state.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class StoragePermissionCubit extends Cubit<StoragePermissionState> {
  StoragePermissionCubit() : super(StoragePermissionInitial());

  Future<void> requestPermission() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      emit(StoragePermissionGranted());
    } else if (status.isDenied) {
      emit(StoragePermissionDenied());
    } else if (status.isPermanentlyDenied) {
      emit(StoragePermissionPermanentlyDenied());
    } else {
      emit(StoragePermissionInitial());
    }
  }
}
