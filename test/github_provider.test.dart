import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/github.dart';
import 'package:riverpod/riverpod.dart';
import 'package:rnr/providers/browse_provider.dart';
import 'package:rnr/repos/sources/revanced.gmscore.dart';
import 'package:rnr/repos/sources/revancedapks.buildapps.dart';
import 'package:rnr/services/github.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Some description',
    () async {
      await dotenv.load();
      final git = GitHub(
        auth: Authentication.bearerToken(
          dotenv.get('GITHUB_TEST_PAT'),
        ),
      );

      final repo = GmsCore();
      final slug = RepositorySlug(repo.repoOwner, repo.repoName);

      final s = await git.listReleasesWithPagination(slug).toList();

      final s2 = await git.listReleasesWithPagination(slug, page: 2).toList();
      final s3 = await git.listReleasesWithPagination(slug, page: 3).toList();

      print(s);
      //
      // await for (final rel in s) {
      //   print(rel.name);
      // }
    },
  );
}
