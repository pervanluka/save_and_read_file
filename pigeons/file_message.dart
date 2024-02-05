import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/dev/flutter/pigeon_test/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/Messages.g.swift',
  swiftOptions: SwiftOptions(),
))
class FileMessage {
  final String text;
  final String content;

  FileMessage({required this.text, required this.content});
}

class Response {
  final bool successful;
  final String? error;

  Response({required this.successful, required this.error});
}

@HostApi()
abstract class DeviceFileApi {
  @async
  Response saveFile(FileMessage msg);
}
