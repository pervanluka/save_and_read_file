import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

abstract interface class IDevicePermissionHandler {
  Future<bool> requestPermissionStorage();
}

class DevicePermissionHandler extends IDevicePermissionHandler {
  final DeviceInfoPlugin _deviceInfoPlugin;

  DevicePermissionHandler({required DeviceInfoPlugin deviceInfoPlugin})
      : _deviceInfoPlugin = deviceInfoPlugin;
  @override
  Future<bool> requestPermissionStorage() async {
    if (Platform.isAndroid) {
      final androidVersionInfo = await _deviceInfoPlugin.androidInfo;
      if (androidVersionInfo.version.sdkInt < 33) {
        final status = await Permission.storage.status;
        if (!status.isGranted) {
          final request = await Permission.contacts.request();
          return request.isGranted;
        } else if (status.isPermanentlyDenied) {
          openAppSettings();
        }
      }
    }
    return true;
  }
}
