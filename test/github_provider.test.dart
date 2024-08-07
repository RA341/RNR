// ignore_for_file: unused_local_variable

import 'package:github/github.dart';
import 'package:rnr/repos/sources/revanced.gmscore.dart';
import 'package:rnr/services/github.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Some description',
    () async {
      final git = GitHub();

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


