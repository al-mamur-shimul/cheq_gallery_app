import Photos

@objc(GalleryImages)
class GalleryImages: NSObject {
    @objc
    func fetchDeviceImages(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        var albums: [String: [String]] = [:]

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let userAlbumsOptions = PHFetchOptions()
        userAlbumsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")

        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: userAlbumsOptions)

        userAlbums.enumerateObjects { (collection, _, _) in
            let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
            var imagePaths: [String] = []

            assets.enumerateObjects { (asset, _, _) in
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                options.deliveryMode = .highQualityFormat

                PHImageManager.default().requestImageData(for: asset, options: options) { (data, _, _, info) in
                    if let fileUrl = info?["PHImageFileURLKey"] as? URL {
                        imagePaths.append(fileUrl.path)
                    }
                }
            }

            if !imagePaths.isEmpty {
                albums[collection.localizedTitle ?? "Unknown"] = imagePaths
            }
        }

        resolve(albums)
    }
}