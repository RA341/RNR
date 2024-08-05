import 'package:apk_installer/apk_installer.dart';
import 'package:flutter/foundation.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:rnr/services/file_manager.dart';

final appMan = AppManager.i;

class AppManager {
  AppManager._();

  static AppManager? inst;

  static AppManager get i => inst ??= AppManager._();

  // Info when installing app from ui
  String? installingApp;
  int? tagId;

  // AppAsset? asset;
  String? repoUrl;

  Future<void> installApk(Uri apkPath) async {
    await ApkInstaller.installApk(filePath: apkPath.path);
  }

  Future<List<AppInfo>> getAllApps() {
    return InstalledApps.getInstalledApps(true, true);
  }
}
