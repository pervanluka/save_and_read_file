import 'package:save_content_as_txt_file/src/messages.g.dart';

abstract interface class IDeviceStorageHandler {
  Future<FileResponse> saveFile(String fileName, String content);
  Future<FileResponse> readFile(String fileName);
}

class DeviceStorageHandler extends IDeviceStorageHandler {
  final DeviceFileApi _deviceFileApi;

  DeviceStorageHandler({required DeviceFileApi deviceFileApi}) : _deviceFileApi = deviceFileApi;
  @override
  Future<FileResponse> saveFile(String fileName, String content) async {
    final FileResponse result = await _deviceFileApi.saveFile(
      SaveFileMessage(
        filename: fileName,
        content: content,
      ),
    );
    return result;
  }

  @override
  Future<FileResponse> readFile(String fileName) async {
    final FileResponse result = await _deviceFileApi.readFile(
      ReadFileMessage(
        filename: fileName,
      ),
    );
    return result;
  }
}
