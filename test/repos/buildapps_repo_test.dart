// ignore_for_file: unused_local_variable


import 'package:github/github.dart';
import 'package:rnr/repos/sources/revancedapks.buildapps.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Test scraper',
    () async {
      final git = GitHub();

      final repo = BuildApps();
      final slug = RepositorySlug(repo.repoOwner, repo.repoName);
      final releases = await git.repositories.getLatestRelease(slug);

      final apps = repo.filterReleases(releases);

      apps.forEach(print);
    },
  );
}
