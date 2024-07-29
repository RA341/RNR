import 'package:github/github.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/utils/services.dart';

class GithubManger {
  GithubManger._() {
    gitI = GitHub();
  }

  static GithubManger? gitMan;

  static GithubManger get i => gitMan ??= GithubManger._();

  late final GitHub gitI;

  Future<List<DisplayApp>> getReleases(IRepo repo) async {
    final slug = RepositorySlug(
      repo.repoOwner,
      repo.repoName,
    );

    final release = await gitI.repositories.getLatestRelease(slug);

    if (release.assets == null) {
      throw Exception('No assets found for this release');
    }

    return repo.filterReleases(release);
  }

  Future<DisplayRelease> getReleaseTag({
    required RepositorySlug slug,
    required IRepo repo,
    required int tag,
  }) async {
    final release = await gitI.repositories.getReleaseById(slug, tag);

    if (release.assets == null) {
      throw Exception('No assets found for this release');
    }

    return DisplayRelease(
      release: release,
      assets: repo.filterReleases(release),
    );
  }

  // Stream<AppRelease> getReleases(
  //   RepositorySlug slug,
  //   AppRelease Function(Release input) filter, {
  //   int? installedTag,
  //   int tagsToFetch = 0,
  // }) async* {
  //   final release = await gitI.repositories.getLatestRelease(slug);
  //
  //   if (tagsToFetch != 0 && installedTag != null) {
  //     for (int x = tagsToFetch; x > 0; x--) {
  //       yield await fetchRelease(slug, filter, installedTag);
  //     }
  //   }
  //
  //   if (installedTag != null && release.id == installedTag) {
  //     throw Exception(
  //         "No new release found.\nCurrent tag: $installedTag ,Found tag ${release.id ?? 'No id found'}");
  //   }
  //
  //   if (release.assets == null) {
  //     throw Exception('No releases found on this tag');
  //   }
  //
  //   yield filter(release);
  // }
  //
  // Future<AppRelease> fetchRelease(
  //   RepositorySlug slug,
  //   AppRelease Function(Release input) filter,
  //   int tag,
  // ) async {
  //   final release = await gitI.repositories.getReleaseById(slug, tag);
  //
  //   if (release.assets == null) {
  //     throw Exception("No releases found on this tag");
  //   }
  //
  //   return filter(release);
  // }

  RepositorySlug generateRepoSlug(String link) {
    final url = Uri.parse(link);
    final pathList = url.pathSegments;
    final user = pathList[pathList.length - 2];
    final repo = pathList.last;
    return RepositorySlug(user, repo);
  }
}
