import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/github.dart';
import 'package:rnr/repos/sources/revancedapks.buildapps.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Test scraper',
    () async {
      await dotenv.load();
      final git = GitHub(
        auth: Authentication.bearerToken(
          dotenv.get('GITHUB_TEST_PAT'),
        ),
      );

      final repo = BuildApps();
      final slug = RepositorySlug(repo.repoOwner, repo.repoName);
      final releases = await git.repositories.getLatestRelease(slug);

      final apps = repo.filterReleases(releases);

      apps.forEach(print);
    },
  );
}
