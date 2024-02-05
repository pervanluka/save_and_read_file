import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_content_as_txt_file/cubit/file_cubit.dart';
import 'package:save_content_as_txt_file/cubit/file_state.dart';
import 'package:save_content_as_txt_file/service_locator/service_locator.dart';
import 'package:toastification/toastification.dart';

void main() {
  runZonedGuarded(() async {
    await ServiceLocator.instance.init();
    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) async {});
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
          deviceDataHandler: sl(),
          devicePermissionHandler: sl(),
        ),
        child: const SaveFileScreen(),
      ),
    );
  }
}

class SaveFileScreen extends StatefulWidget {
  const SaveFileScreen({super.key});

  @override
  State<SaveFileScreen> createState() => _SaveFileScreenState();
}

class _SaveFileScreenState extends State<SaveFileScreen> {
  TextEditingController fileNameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    fileNameController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Text as Text file'),
        backgroundColor: Colors.deepPurpleAccent.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<FileCubit, FileState>(
          listener: (context, state) {
            if (state is StoragePermissionDenied) {
              toastification.show(
                context: context,
                title: const Text('Storage permission is denied!'),
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 2),
              );
            }

            if (state is StoragePermissionGranted) {
              context.read<FileCubit>().saveFile(fileNameController.text, contentController.text);
            }
          },
          builder: (context, state) {
            return switch (state) {
              FileLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              FileLoaded() => const Center(
                  child: Text('Successfuly saved into internal storage!'),
                ),
              FileInitial() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: fileNameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter title for file',
                        labelStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      maxLines: 1,
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: TextField(
                        controller: contentController,
                        decoration: const InputDecoration(
                          labelText: 'Enter content',
                          labelStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () => context.read<FileCubit>().permissionCheck(),
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              _ => const Center(
                  child: Text('Default state'),
                ),
            };
          },
        ),
      ),
    );
  }
}