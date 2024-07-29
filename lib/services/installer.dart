// import 'package:apk_installer/apk_installer.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/foundation.dart';
// import 'package:isar/isar.dart';
// import 'package:rnr/models/display_app.dart.dart';
// import 'package:rnr/models/installed_app.dart';
// import 'package:rnr/services/file_manager.dart';
//
// final appMan = AppManager.i;
//
// class AppManager {
//   AppManager._();
//
//   static AppManager? inst;
//
//   static AppManager get i => inst ??= AppManager._();
//
//   late List<Application> installedAppList = [];
//   late List<Application> allAppList;
//
//
//   // Info when installing app from ui
//   String? installingApp;
//   int? tagId;
//   AppAsset? asset;
//   String? repoUrl;
//
//   Future<void> installApk(Uri apkPath) async {
//     await ApkInstaller.installApk(filePath: apkPath.path);
//   }
//
//   Future<void> listenToInstalledApps() async {
//     await getInstalledApps();
//     _debugP();
//     DeviceApps.listenToAppsChanges().listen((apps) async {
//       if (apps.event == ApplicationEventType.installed ||
//           apps.event == ApplicationEventType.uninstalled ||
//           apps.event == ApplicationEventType.updated) {
//         print(installingApp);
//         print(apps.packageName);
//         print(tagId);
//         print(asset);
//
//         if (installingApp != null && installingApp == apps.packageName) {
//           fileMan.writeRelease(
//             repoUrl!,
//             tagId!,
//             [asset!],
//             apps.packageName,
//           );
//         }
//
//         // reset state vars
//         installingApp ??= null;
//         tagId ??= null;
//         repoUrl ??= null;
//         asset ??= null;
//
//         await getInstalledApps();
//         _debugP();
//       }
//     });
//   }
//
//   Future<void> getInstalledApps() async {
//     allAppList = await DeviceApps.getInstalledApplications();
//
//     for (var app in allAppList) {
//       final res = await fileMan.isar.installedReleases
//           .filter()
//           .installedElement((q) => q.appIdEqualTo(app.packageName))
//           .findFirst();
//
//       print(res);
//     }
//   }
//
//   void _debugP() {
//     if (kDebugMode) {
//       for (var e in appMan.installedAppList) {
//         print(e.appName);
//         print(e.packageName);
//       }
//     }
//   }
// }
