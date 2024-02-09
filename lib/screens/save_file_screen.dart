import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_and_read_file/cubit/file_cubit.dart';
import 'package:save_and_read_file/cubit/file_state.dart';
import 'package:toastification/toastification.dart';

class SaveFileScreen extends StatefulWidget {
  const SaveFileScreen({super.key});

  @override
  State<SaveFileScreen> createState() => _SaveFileScreenState();
}

class _SaveFileScreenState extends State<SaveFileScreen> {
  TextEditingController fileNameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController fileNameReadController = TextEditingController();

  @override
  void dispose() {
    fileNameController.dispose();
    contentController.dispose();
    fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save and read file'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<FileCubit>().refresh(),
          )
        ],
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

            if (state is FileInitial) {
              contentController.clear();
              fileNameController.clear();
              fileNameReadController.clear();
            }

            if (state is FileContentLoaded) {
              // Display a toast or a message indicating the file content is loaded
              toastification.show(
                context: context,
                title: const Text('File successfuly loaded!'),
                type: ToastificationType.success,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 2),
              );

              WidgetsBinding.instance.addPostFrameCallback((_) {
                fileNameController.text = state.fileName;
                contentController.text = state.content;
              });
            }
          },
          builder: (context, state) {
            return switch (state) {
              FileLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              FileSavedSuccessfully() => const Center(
                  child: Text('Successfuly saved into internal storage!'),
                ),
              FileInitial() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: fileNameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter file name',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.read<FileCubit>().permissionCheck(),
                          child: const Text(
                            'Save File',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        ElevatedButton(
                          onPressed: () => _showReadFileDialog(context),
                          child: const Text('Read File', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              FileContentLoaded() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: fileNameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter file name',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.read<FileCubit>().permissionCheck(),
                          child: const Text(
                            'Save File',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        ElevatedButton(
                          onPressed: () => _showReadFileDialog(context),
                          child: const Text('Read File', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              FileFailed() => Center(
                  child: Text(state.error),
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            };
          },
        ),
      ),
    );
  }

  void _showReadFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<FileCubit>(),
          child: AlertDialog(
            title: const Text("Enter File Name"),
            content: TextField(
              controller: fileNameReadController,
              decoration: const InputDecoration(
                labelText: 'Enter file name',
                labelStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Read"),
                onPressed: () {
                  context.read<FileCubit>().readFile(fileNameReadController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
