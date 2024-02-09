import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:save_and_read_file/cubit/file_cubit.dart';
import 'package:save_and_read_file/screens/save_file_screen.dart';
import 'package:save_and_read_file/service_locator/service_locator.dart';

void main() {
  runZonedGuarded(() async {
    await ServiceLocator.instance.init();
    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) async {
    final logger = Logger();
    logger.e(error, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => FileCubit(
          deviceStorageHandler: sl(),
          devicePermissionHandler: sl(),
        ),
        child: const FileScreen(),
      ),
    );
  }
}
