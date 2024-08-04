// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:release_provider.dart/release_provider.dart.dart';
// import 'package:rnr/services/file_manager.dart';
// import 'package:rnr/services/release_provider.dart.dart';
//
// class DeviceManager {
//   DeviceManager._();
//
//   static DeviceManager get i => _dev ??= DeviceManager._();
//
//   static DeviceManager? _dev;
//
//   String? supportedArch;
//
//   Future<void> getDeviceInfo() async {
//     final info = DeviceInfoPlugin();
//     final androidInfo = await info.androidInfo;
//
//     // get the supported arch
//     // eg [arm64-v8a] -> v8a
//     supportedArch = androidInfo.supported64BitAbis[0].split('-')[0];
//   }
// }
//
// /// FNV-1a 64bit hash algorithm optimized for Dart Strings
// int fastHash(String string) {
//   var hash = 0xcbf29ce484222325;
//
//   var i = 0;
//   while (i < string.length) {
//     final codeUnit = string.codeUnitAt(i++);
//     hash ^= codeUnit >> 8;
//     hash *= 0x100000001b3;
//     hash ^= codeUnit & 0xFF;
//     hash *= 0x100000001b3;
//   }
//
//   return hash;
// }
//
// final git = GithubManger.i;
// final file = FileManager.i;
// final dev = DeviceManager.i;
