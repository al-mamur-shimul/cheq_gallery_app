import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let galleryImagesChannel = FlutterMethodChannel(name: "cheq_gallery_app/gallery_images",
                                                    binaryMessenger: controller.binaryMessenger)

    galleryImagesChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "fetchDeviceImages" {
        let galleryImages = GalleryImages()
        galleryImages.fetchDeviceImages(result, reject: { (code, message, error) in
          result(FlutterError(code: code, message: message, details: error?.localizedDescription))
        })
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}