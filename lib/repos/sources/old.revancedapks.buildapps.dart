// import 'package:github.dart/github.dart.dart';
// import 'package:rnr/services/installer.dart';
// import 'package:rnr/services/utils.dart';
//
//
// // regex to detect vx.x.x
// RegExp versionPattern = RegExp(r'v\d+\.\d+\.\d+');
// // regex to detect vx.x
// RegExp versionPattern2 = RegExp(r'\bv\d+(\.\d+)?\b');
//
// /// TODO create test
// /// filter for https://github.com/revanced-apks/build-apps.git
// class BuildApps extends RepoFilter {
//   static const String repoUrl = 'https://github.com/revanced-apks/build-apps';
//   static final int hash = fastHash(repoUrl);
//
//   static const label = 'BuildApps';
//
//   @override
//   Map<String, AppAsset> filter(List<ReleaseAsset> assets) {
//     final appList = <String, AppAsset>{};
//
//     for (var appRelease in assets) {
//       // filter out zip files
//       if (appRelease.contentType != githubApkType) continue;
//
//       final sp = appRelease.name?.split('-');
//
//       if (sp == null) continue;
//
//       final (appName, arch, version) = extractMetaData(sp);
//
//       if (appList.containsKey(appName)) {
//         // add new architecture
//         final entry = {arch: appRelease};
//
//         appList[appName]!.assetList.addAll(entry);
//       } else {
//         // add new app
//         final asset = {
//           appName: AppAsset(
//             name: appName,
//             version: version,
//             assetList: {arch: appRelease},
//           )
//         };
//
//         // add new app
//         appList.addAll(asset);
//       }
//     }
//
//     return appList;
//   }
//
//   @override
//   (String, String, String?) extractMetaData(List<String> names) {
//     String name = '';
//     String arch = '';
//     String? version;
//     bool isExtendedApp = false;
//
//     final noOfNames = names.length;
//
//     for (int index = 0; index < noOfNames; index++) {
//       final ele = names[index];
//
//       // skip if key is 'revanced'
//       if (ele == revancedKey) continue;
//
//       // check for extended key
//       // if already true skip
//       if (!isExtendedApp && ele == ytExtendedKey) {
//         isExtendedApp = true;
//         continue;
//       }
//
//       // check if version number
//       // skip if already set
//       if (version == null &&
//           (ele.contains(versionPattern) || ele.contains(versionPattern2))) {
//         version = ele;
//         continue;
//       }
//
//       final secondLastElement = noOfNames - 2;
//       final lastElement = noOfNames - 1;
//
//       // check if element contains arch type
//       // As of 1/19/24 present at the last to second last element
//       // eg  music-revanced-v6.34.51-arm64-v8a.apk
//       //          these elements ----> |    |
//       if (index == secondLastElement || index == lastElement) {
//         arch += '$ele-';
//         continue;
//       }
//
//       // set everything else as the name
//       name += ele;
//     }
//     // remove trailing '-'
//     // arch = arch.replaceRange(arch.length - 1, arch.length, '');
//     arch = arch.replaceFirst(RegExp(r'\.apk-'), '');
//     if (isExtendedApp) name += ' $ytExtendedKey';
//     return (name, arch, version);
//   }
//
//   String searchIfAppInstalled(List<AppRelease> releases) {
//     final installed = appMan.installedAppList;
//     for (int x = 0; x < releases.length; x++) {
//       final ele = releases[x];
//       final asset =
//           ele.assets.first.assetList[ele.assets.first.assetList.keys.first]!;
//       final appName = asset.name!.split('-');
//
//       appName.removeWhere((element) =>
//           element == revancedKey || element.contains(versionPattern));
//
//       print(appName);
//
//       try {
//         final app = installed.firstWhere((element) {
//           return element.appName.contains(appName[0]) ||
//               element.appName.contains(appName[1]);
//         });
//         final idx = installed.indexOf(app);
//
//         print(app.appName);
//
//         if (idx == -1) continue;
//         installed.removeAt(idx);
//       } on StateError catch (e) {
//         print(e);
//       }
//     }
//     return '';
//   }
// }
