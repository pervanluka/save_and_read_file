import 'package:equatable/equatable.dart';

sealed class FileState extends Equatable {}

class FileInitial extends FileState {
  @override
  List<Object?> get props => [];
}

class FileLoading extends FileState {
  @override
  List<Object?> get props => [];
}

class StoragePermissionGranted extends FileState {
  @override
  List<Object?> get props => [];
}

class StoragePermissionDenied extends FileState {
  @override
  List<Object?> get props => [];
}

class FileSavedSuccessfully extends FileState {
  final bool success;

  FileSavedSuccessfully({required this.success});

  @override
  List<Object?> get props => [success];
}

class FileContentLoaded extends FileState {
  final String fileName;
  final String content;

  FileContentLoaded({required this.fileName, required this.content});

  @override
  List<Object?> get props => [fileName, content];
}

class FileFailed extends FileState {
  final String error;

  FileFailed({required this.error});
  @override
  List<Object?> get props => [error];
}
