import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_content_as_txt_file/cubit/file_state.dart';
import 'package:save_content_as_txt_file/device_handler/device_permission_handler.dart';
import 'package:save_content_as_txt_file/device_handler/device_storage_handler.dart';

class FileCubit extends Cubit<FileState> {
  final IDeviceStorageHandler _deviceStorageHandler;
  final IDevicePermissionHandler _devicePermissionHandler;
  FileCubit({
    required IDeviceStorageHandler deviceDataHandler,
    required IDevicePermissionHandler devicePermissionHandler,
  })  : _deviceStorageHandler = deviceDataHandler,
        _devicePermissionHandler = devicePermissionHandler,
        super(FileInitial());

  Future<void> saveFile(String fileName, String content) async {
    emit(FileLoading());
    try {
      final result = await _deviceStorageHandler.saveFile(fileName, content);
      if (result.successful) {
        emit(
          FileLoaded(
            success: result.successful,
          ),
        );
      } else {
        emit(
          FileFailed(
            error: result.error ?? 'Failed to save!',
          ),
        );
      }
    } catch (e) {
      emit(FileFailed(error: 'Failed to save the file: $e'));
    }
  }

  Future<void> permissionCheck() async {
    emit(FileLoading());
    final result = await _devicePermissionHandler.requestPermissionStorage();
    if (result) {
      emit(StoragePermissionGranted());
    } else {
      emit(StoragePermissionDenied());
    }
  }
}
