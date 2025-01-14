package com.sh1mul.gallery

import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.provider.MediaStore
import android.content.ContentResolver
import android.database.Cursor
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.sh1mul.gallery/device_images"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDeviceImages") {
                val images = getDeviceImages()
                if (images != null) {
                    result.success(images)
                } else {
                    result.error("UNAVAILABLE", "Images not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDeviceImages(): Map<String, List<String>>? {
        val resolver: ContentResolver = contentResolver
        val uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val projection = arrayOf(
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media.DATA
        )
        val cursor: Cursor? = resolver.query(uri, projection, null, null, null)
        val albumMap = mutableMapOf<String, MutableList<String>>()

        cursor?.use {
            val bucketColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME)
            val dataColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)

            while (cursor.moveToNext()) {
                val bucket = cursor.getString(bucketColumn) ?: continue
                val data = cursor.getString(dataColumn)

                if (albumMap.containsKey(bucket)) {
                    albumMap[bucket]?.add(data)
                } else {
                    albumMap[bucket] = mutableListOf(data)
                }
            }
        }

        return albumMap
    }
}