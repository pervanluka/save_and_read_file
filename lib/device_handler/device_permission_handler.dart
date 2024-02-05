import 'package:permission_handler/permission_handler.dart';

abstract interface class IDevicePermissionHandler {
  Future<bool> requestPermissionStorage();
}

class DevicePermissionHandler extends IDevicePermissionHandler {
  @override
  Future<bool> requestPermissionStorage() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      final request = await Permission.contacts.request();
      return request.isGranted;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return true;
  }
}
