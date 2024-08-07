import 'package:github/github.dart';
import 'package:rnr/models/display_app.dart';
import 'package:rnr/repos/irepo.dart';

class BuildApps extends IRepo {
  @override
  final repoName = 'build-apps';

  @override
  final repoOwner = 'revanced-apks';

  @override
  List<DisplayApp> filterReleases(Release release) {
    final apps = <DisplayApp>[];

    for (final e in release.assets!) {
      final (name, version, arch) = _collectMetaData(e.name!);
      apps.add(
        DisplayApp(
          name: name,
          arch: arch,
          version: version,
          downloadUrl: e.browserDownloadUrl ?? '',
          size: e.size ?? 0,
          releaseDate: e.createdAt ?? DateTime(69), // placeholder year
        ),
      );
    }

    return apps;
  }

  (String, String, String) _collectMetaData(String assetName) {
    final splits = assetName.split('-');

    if (splits.length == 5) {
      // handling
      // 0 = "instagram"
      // 1 = "revanced"
      // 2 = "v341.0.0.45.100"
      // 3 = "arm"
      // 4 = "v7a.apk"
      final name = '${splits[0]} ${splits[1]}';
      final version = splits[2];
      // remove .apk
      final arch = '${splits[3]}-${splits[4].split('.')[0]}';

      return (name, version, arch);
    } else if (splits.length == 6) {
      // handling extended
      // 0 = "music"
      // 1 = "revanced"
      // 2 = "extended"
      // 3 = "v7.10.52"
      // 4 = "arm"
      // 5 = "v7a.apk"

      if (!splits[3].startsWith('v')) {
        // handle this weird edge case
        // 0 = "reddit"
        // 1 = "extended"
        // 2 = "revanced"
        // 3 = "extended" <-- extra
        // 4 = "v2024.17.0"
        // 5 = "all.apk"
        final name = '${splits[0]} ${splits[1]} ${splits[2]}';
        final version = splits[4];
        // remove .apk
        final arch = splits[5].split('.')[0];
        return (name, version, arch);
      }

      final name = '${splits[0]} ${splits[1]} ${splits[2]}';
      final version = splits[3];
      // remove .apk
      final arch = '${splits[4]}-${splits[5].split('.')[0]}';

      return (name, version, arch);
    } else if (splits.length == 4) {
      // handling
      // 0 = "reddit"
      // 1 = "revanced"
      // 2 = "v2024.17.0"
      // 3 = "all.apk"

      final name = '${splits[0]} ${splits[1]}';
      final version = splits[2];
      // remove .apk
      final arch = splits[3].split('.')[0];

      return (name, version, arch);
    }

    // unhandled case
    return (assetName, '', '');
  }
}
