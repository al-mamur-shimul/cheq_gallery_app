import 'package:flutter/services.dart';

class GalleryImages {
  static const MethodChannel _channel = MethodChannel(
    'com.sh1mul.gallery/device_images',
  );

  static Future<Map<String, List<String>>> fetchDeviceImages() async {
    final deviceImages = <String, List<String>>{};

    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'getDeviceImages',
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
    } on PlatformException catch (e) {
      return {};
    }
  }
}
