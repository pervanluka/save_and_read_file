package com.example.save_content_as_txt_file

import DeviceFileApiImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Create an instance of the DeviceFileApiImpl
        val deviceFileApi = DeviceFileApiImpl(this)

        // Set up the DeviceFileApi with the flutterEngine's binaryMessenger
        DeviceFileApi.Companion.setUp(flutterEngine.dartExecutor.binaryMessenger, deviceFileApi)
    }
}
