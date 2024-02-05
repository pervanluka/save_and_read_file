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

class FileLoaded extends FileState {
  final bool success;

  FileLoaded({
    required this.success,
  });
  @override
  List<Object?> get props => [success];
}

class FileFailed extends FileState {
  final String error;

  FileFailed({required this.error});
  @override
  List<Object?> get props => [error];
}
