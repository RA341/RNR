import 'package:github/github.dart';
import 'package:rnr/database/models/display_app.dart';

abstract class IRepo {
  String get repoOwner;

  String get repoName;

  List<DisplayApp> filterReleases(Release release);
}
