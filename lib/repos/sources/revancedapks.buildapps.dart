import 'package:github/github.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/repos/irepo.dart';

class BuildApps extends IRepo {
  @override
  final repoName = 'revancedapks';

  @override
  final repoOwner = 'buildapps';

  @override
  List<DisplayApp> filterReleases(Release release) {
    for (final e in release.assets!) {
      print(e.name);
      print(e.size);
      print(e.downloadCount);
      print(e.size);
      print(e.updatedAt);
      print(e.createdAt);
    }

    return List.empty();
  }
}
