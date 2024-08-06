// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:rnr/models/display_app_store.dart.dart';
// import 'package:rnr/models/installed_app_store.dart';
//
// final fileMan = FileManager.i;
//
// class FileManager {
//   late final Directory downloadPath;
//   late final Directory root;
//   late final Dio dio;
//
//   static FileManager? _instance;
//
//   static FileManager get i => _instance ??= FileManager._();
//   late final Isar isar;
//
//   FileManager._();
//
//   Future<void> init() async {
//     dio = Dio();
//     await _createSupportFolders();
//     final dir = await getApplicationDocumentsDirectory();
//     isar = await Isar.open(
//       [InstalledReleaseSchema],
//       directory: dir.path,
//     );
//   }
//
//   Future<void> _createSupportFolders() async {
//     root = await getApplicationDocumentsDirectory();
//     Directory downloads = Directory('${root.path}/downloads');
//     downloadPath = await downloads.create(recursive: true);
//   }
//
//   Uri getFilePath(String appName) {
//     return Uri.file('${FileManager.i.downloadPath.path}/$appName');
//   }
//
//   Future<void> deleteApk(
//     Uri filePath,
//   ) async {
//     final file = File.fromUri(filePath);
//     try {
//       await file.delete();
//     } on Exception catch (e) {
//       debugPrint('Failed to delete file');
//       debugPrint(e.toString());
//     }
//   }
//
//   Future<void> downloadApk(
//     String fileName,
//     String uri,
//     void Function(int, int)? onReceiveProgress,
//     CancelToken cancel,
//   ) async {
//     await dio.download(
//       uri,
//       '${downloadPath.path}/$fileName',
//       onReceiveProgress: onReceiveProgress,
//       cancelToken: cancel,
//     );
//   }
//
//   void writeRelease(
//       String repoUrl, int id, List<AppAsset> assets, String packageName) async {
//     final inst = InstalledRelease();
//     inst.repoUrl = repoUrl;
//     inst.tag = id;
//     inst.installed = [];
//
//     for (var asset in assets) {
//       final installedApp = InstalledApp();
//       installedApp.webId = asset.name;
//       installedApp.appId = packageName;
//       inst.installed!.add(installedApp);
//     }
//
//     await isar.writeTxn(() => isar.installedReleases.put(inst));
//   }
// }
