import 'package:save_content_as_txt_file/src/messages.g.dart';

abstract interface class IDeviceStorageHandler {
  Future<Response> saveFile(String fileName, String content);
}

class DeviceStorageHandler extends IDeviceStorageHandler {
  final DeviceFileApi _deviceFileApi;

  DeviceStorageHandler({required DeviceFileApi deviceFileApi}) : _deviceFileApi = deviceFileApi;
  @override
  Future<Response> saveFile(String fileName, String content) async {
    final Response result = await _deviceFileApi.saveFile(
      FileMessage(
        text: fileName,
        content: content,
      ),
    );
    return result;
  }
}
