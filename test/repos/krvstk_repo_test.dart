import 'package:github/github.dart';
import 'package:rnr/repos/sources/krvstek.rvx-apks.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Test scraper',
    () async {
      final git = GitHub();

      final repo = RvxApks();

      final slug = RepositorySlug(repo.repoOwner, repo.repoName);
      // 26 release has a lot more apps
      final releases = await git.repositories.getReleaseByTagName(slug, '26');

      final apps = repo.filterReleases(releases);

      apps.forEach(print);
    },
  );
}
