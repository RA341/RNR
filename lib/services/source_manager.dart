import 'package:archive_info/archive_info.dart';
import 'package:dio/dio.dart';
import 'package:github/github.dart';
import 'package:rnr/models/display_app.dart';
import 'package:rnr/models/installed_app.dart';
import 'package:rnr/services/app_manager.dart';
import 'package:rnr/services/file_manager.dart';
import 'package:rnr/utils/services.dart';

final sourceMan = AppSourceManager.i;

class AppSourceManager {
  AppSourceManager._();

  static AppSourceManager? inst;

  static AppSourceManager get i => inst ??= AppSourceManager._();

  Future<void> installNewApp(Release release, DisplayApp app) async {
    final fileName = '${app.name}_${app.arch}';
    final savePath = fileMan.generateDownloadPath(fileName);

    final cancelToken = CancelToken();

    // download app
    await fileMan.downloadApk(
      savePath.path,
      app.downloadUrl,
      (p0, p1) {},
      cancelToken,
    );

    // run archive info
    final packageName = await ArchiveInfo().getPackageName(savePath.path);

    if (packageName == null) {
      logger
        ..e('Could not find package name from apk file: ${savePath.path}')
        ..i('add the app manually');
    }

    await appMan.installApk(savePath).onError(
      (error, stackTrace) {
        print(error);
      },
    ).then(
      (value) {
        print('app should be installed');
      },
    );

    print('wow');

    logger.i('App $fileName installed, with packagename: $packageName');

    // store metadata info
    //  get installed package name

    // install app

    // store to db
  }

  void updateExistingApp(String packageName, Release release, DisplayApp app) {
    // download app

    // run archive info

    // store metadata info
    //  ~get installed package name~

    // install app

    // store to db
  }

// void writeRelease(
//     String repoUrl, int id, List<AppAsset> assets, String packageName) async {
//   final inst = InstalledRelease();
//   inst.repoUrl = repoUrl;
//   inst.tag = id;
//   inst.installed = [];
//
//   for (var asset in assets) {
//     final installedApp = InstalledApp();
//     installedApp.webId = asset.name;
//     installedApp.appId = packageName;
//     inst.installed!.add(installedApp);
//   }
//
//   await isar.writeTxn(() => isar.installedReleases.put(inst));
// }
}
