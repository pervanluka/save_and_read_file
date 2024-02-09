import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:save_and_read_file/cubit/file_state.dart';
import 'package:save_and_read_file/device_handler/device_permission_handler.dart';
import 'package:save_and_read_file/device_handler/device_storage_handler.dart';

class FileCubit extends Cubit<FileState> {
  final IDeviceStorageHandler _deviceStorageHandler;
  final IDevicePermissionHandler _devicePermissionHandler;
  FileCubit({
    required IDeviceStorageHandler deviceStorageHandler,
    required IDevicePermissionHandler devicePermissionHandler,
  })  : _deviceStorageHandler = deviceStorageHandler,
        _devicePermissionHandler = devicePermissionHandler,
        super(FileInitial());

  final logger = Logger();

  Future<void> saveFile(String fileName, String content) async {
    emit(FileLoading());
    try {
      final result = await _deviceStorageHandler.saveFile(fileName, content);
      if (result.successful) {
        emit(
          FileSavedSuccessfully(
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

  Future<void> readFile(String fileName) async {
    emit(FileLoading());
    try {
      final result = await _deviceStorageHandler.readFile(fileName);
      if (result.successful) {
        emit(
          FileContentLoaded(
            fileName: fileName,
            content: result.content ?? '',
          ),
        );
      } else {
        emit(FileFailed(
          error: result.error ?? 'Failed to read file!',
        ));
      }
    } catch (e) {
      emit(FileFailed(error: 'Failed to read the file: $e'));
    }
  }

  void refresh() {
    emit(FileInitial());
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
