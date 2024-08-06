import 'package:archive_info/archive_info.dart';
import 'package:github/github.dart';
import 'package:rnr/models/display_app.dart';

class AppSourceManager {
  void installNewApp(Release release, DisplayApp app) {
    // download app

    // run archive info

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
