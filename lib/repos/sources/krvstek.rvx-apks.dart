import 'package:github/src/common/model/repos_releases.dart';
import 'package:rnr/models/display_app.dart';
import 'package:rnr/repos/irepo.dart';

class RvxApks implements IRepo {
  @override
  final repoName = 'rvx-apks';

  @override
  final repoOwner = 'krvstek';

  @override
  List<DisplayApp> filterReleases(Release release) {
    final apps = <DisplayApp>[];

    for (final e in release.assets!) {
      if (_isNotApk(e.name!)) {
        // file extension must be a apk
        // ignore magisk files
        continue;
      }

      final (name, version, arch) = _collectMetaData(e.name!);

      apps.add(
        DisplayApp(
          name: name,
          arch: arch,
          version: version,
          downloadUrl: e.browserDownloadUrl ?? '',
          size: e.size ?? 0,
          releaseDate: e.createdAt ?? DateTime(69),
        ),
      );
    }

    return apps;
  }

  bool _isNotApk(String assetName) {
    if (assetName.split('.').last == 'apk') {
      return false;
    }
    return true;
  }

  (String, String, String) _collectMetaData(String assetName) {
    final splits = assetName.split('-');

    if (splits.length == 5) {
      if (splits[3].toLowerCase().startsWith('release')) {
        // or
        // 0 = "soundcloud"
        // 1 = "revanced"
        // 2 = "v2024.06.25"
        // 3 = "release" <-- offending element
        // 4 = "all.apk"
        final name = '${splits[0]} ${splits[1]}';
        final version = splits[2];
        // remove .apk
        final arch = splits[4].split('.')[0];
        return (name, version, arch);
      }
      // handling
      // 0 = "reddit"
      // 1 = "revanced"
      // 2 = "extended"
      // 3 = "v2024.17.0"
      // 4 = "all.apk"
      final name = '${splits[0]} ${splits[1]} ${splits[2]}';
      final version = splits[3];
      // remove .apk
      final arch = splits[4].split('.')[0];
      return (name, version, arch);
    } else if (splits.length == 6) {
      // handling extended
      // 0 = "music"
      // 1 = "revanced"
      // 2 = "extended"
      // 3 = "v7.10.52"
      // 4 = "arm"
      // 5 = "v7a.apk"
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
