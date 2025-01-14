import UIKit
import Flutter
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let batteryChannel = FlutterMethodChannel(name: "com.sh1mul.gallery/device_images",
                                                binaryMessenger: controller.binaryMessenger)
      batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "getDeviceImages" {
            self?.getDeviceImagesAndGroupByDate(result: result)
            } else {
            result(FlutterMethodNotImplemented)
        }

      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  private func getDeviceImagesAndGroupByDate(result: FlutterResult) {
      var imagesByDate = [String: [String]]()

      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

      let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

      fetchResult.enumerateObjects { (asset, _, _) in
          if let creationDate = asset.creationDate {
              let dateString = DateFormatter.localizedString(from: creationDate, dateStyle: .short, timeStyle: .none)

              let options = PHImageRequestOptions()
              options.isSynchronous = true
              options.deliveryMode = .highQualityFormat

              PHImageManager.default().requestImageData(for: asset, options: options) { (data, _, _, _) in
                  if let data = data, let imagePath = self.saveImageDataToTemporaryDirectory(data: data) {
                      if imagesByDate[dateString] != nil {
                          imagesByDate[dateString]?.append(imagePath)
                      } else {
                          imagesByDate[dateString] = [imagePath]
                      }
                  }
              }
          }
      }

      result(imagesByDate)
  }

  private func saveImageDataToTemporaryDirectory(data: Data) -> String? {
      let tempDirectory = NSTemporaryDirectory()
      let fileName = UUID().uuidString + ".jpg"
      let fileURL = URL(fileURLWithPath: tempDirectory).appendingPathComponent(fileName)

      do {
          try data.write(to: fileURL)
          return fileURL.path
      } catch {
          print("Error saving image data: \(error)")
          return nil
      }
  }



}