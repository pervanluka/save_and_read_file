import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:save_content_as_txt_file/cubit/file_cubit.dart';
import 'package:save_content_as_txt_file/device_handler/device_permission_handler.dart';
import 'package:save_content_as_txt_file/device_handler/device_storage_handler.dart';
import 'package:save_content_as_txt_file/src/messages.g.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._();
  ServiceLocator._();

  Future<void> init() async {
    sl.registerLazySingleton(
      () => DeviceFileApi(),
    );

    sl.registerLazySingleton(
      () => DeviceInfoPlugin(),
    );

    // Handlers
    sl.registerFactory<IDeviceStorageHandler>(
      () => DeviceStorageHandler(deviceFileApi: sl()),
    );
    sl.registerFactory<IDevicePermissionHandler>(
      () => DevicePermissionHandler(deviceInfoPlugin: sl()),
    );

    // Cubit
    sl.registerFactory<FileCubit>(
      () => FileCubit(
        deviceStorageHandler: sl(),
        devicePermissionHandler: sl(),
      ),
    );
  }
}
