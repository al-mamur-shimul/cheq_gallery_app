import 'package:equatable/equatable.dart';

abstract class StoragePermissionState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoragePermissionInitial extends StoragePermissionState {}

class StoragePermissionGranted extends StoragePermissionState {}

class StoragePermissionDenied extends StoragePermissionState {}

class StoragePermissionPermanentlyDenied extends StoragePermissionState {}
