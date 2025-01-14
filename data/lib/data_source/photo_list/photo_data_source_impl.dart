import 'package:data/data_source/photo_list/photo_data_source.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PhotoDataSource)
class PhotoDataSourceImpl implements PhotoDataSource {
  @override
  Future<Map<String, List<String>>> fetchDeviceImages() async {
    final deviceImages = <String, List<String>>{};

    try {
      final result = await channel.invokeMethod<Map<dynamic, dynamic>>(
        methodName,
      );

      final map = result?.cast<String, List<dynamic>>();
      map?.forEach((key, value) {
        final images = <String>[];

        for (final element in value) {
          images.add(element.toString());
        }
        deviceImages[key] = images;
      });
      return deviceImages;
    } on PlatformException catch (_) {
      return {};
    }
  }

  String get methodName => 'getDeviceImages';

  MethodChannel get channel => MethodChannel(
        'com.sh1mul.gallery/device_images',
      );
}
