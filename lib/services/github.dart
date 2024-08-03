import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github/github.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/utils/services.dart';

class GithubManger {
  GithubManger._() {
    final tk = settings.getGithubToken();
    gitI = tk == null ? GitHub() : GitHub(auth: Authentication.bearerToken(tk));
  }

  static GithubManger? gitMan;

  static GithubManger get i => gitMan ??= GithubManger._();

  late final GitHub gitI;

  final appStream = StreamController<DisplayRelease>();

  void dispose() {
    gitI.dispose();
    // appStream.done;
  }

  Future<List<DisplayRelease>> getReleasesF(
    IRepo repo, {
    int page = 1,
    int perPage = 3,
  }) async {
    final slug = RepositorySlug(
      repo.repoOwner,
      repo.repoName,
    );

    final tags = await collectTags(slug, page, perPage);
    logRateLimits();
    final results = <DisplayRelease>[];

    for (final tag in tags) {
      final release =
          await gitI.repositories.getReleaseByTagName(slug, tag.name);
      logRateLimits();

      if (release.assets == null) {
        logger.w('No assets found for tag:${release.id}');
        results.add(
          DisplayRelease(
            release: release,
            assets: null,
          ),
        );
      }

      results.add(
        DisplayRelease(
          release: release,
          assets: repo.filterReleases(release),
        ),
      );
    }

    return results;
  }

  Stream<DisplayRelease> getReleasesS(
    IRepo repo, {
    int page = 1,
    int perPage = 3,
  }) async* {
    final slug = RepositorySlug(
      repo.repoOwner,
      repo.repoName,
    );

    await for (final tag in collectTagsS(slug, page, perPage)) {
      logRateLimits();
      try {
        final release =
            await gitI.repositories.getReleaseByTagName(slug, tag.name);

        if (release.assets == null) {
          logger.w('No assets found for tag:${release.id}');
          appStream.add( DisplayRelease(
            release: release,
            assets: null,
          ));
        }

        try {
          yield DisplayRelease(
            release: release,
            assets: repo.filterReleases(release),
          );
        } catch (e) {
          logger.e(
            'Failed to filter release ${release.name}: ${release.url}',
            error: e,
          );

          yield DisplayRelease(
            release: release,
            assets: null,
          );
        }
      } catch (e) {
        logger.e(
          'Failed to get release ${tag.name}: ${tag.commit}',
          error: e,
        );

        yield* Stream.error('Failed to get release ${tag.name}');
      }
    }
  }

  Stream<Tag> collectTagsS(
    RepositorySlug slug,
    int page,
    int perPage,
  ) async* {
    yield* gitI.repositories.listTags(slug, page: page, perPage: 5);
  }

  Future<List<Tag>> collectTags(
    RepositorySlug slug,
    int page,
    int perPage,
  ) async {
    return gitI.repositories.listTags(slug, page: page, perPage: 5).toList();
  }

  void logRateLimits() {
    logger.i(
      'rateLimitLimit: ${gitI.rateLimitLimit ?? 0}\n'
      'rateLimitRemaining: ${gitI.rateLimitRemaining ?? 0}\n'
      'rateLimitReset: ${gitI.rateLimitReset ?? 0}',
    );
  }

// Future<DisplayRelease> getReleaseTag({
//   required RepositorySlug slug,
//   required IRepo repo,
//   required Tag tag,
// }) async {
//   final release = await gitI.repositories.getReleaseById(slug, tag);
//
//   if (release.assets == null) {
//     logger.w('No assets found for tag:${release.id}');
//     return DisplayRelease(
//       release: release,
//       assets: null,
//     );
//   }
//
//   return DisplayRelease(
//     release: release,
//     assets: repo.filterReleases(release),
//   );
// }

// RepositorySlug generateRepoSlug(String link) {
//   final url = Uri.parse(link);
//   final pathList = url.pathSegments;
//   final user = pathList[pathList.length - 2];
//   final repo = pathList.last;
//   return RepositorySlug(user, repo);
// }

// TODO convert to StreamNotifier when docs are completed.
// Stream<DisplayRelease> getReleases(IRepo repo) async* {
//   final slug = RepositorySlug(
//     repo.repoOwner,
//     repo.repoName,
//   );
//
//   final release = await gitI.repositories.getLatestRelease(slug);
//
//   if (release.assets == null) {
//     logger.w('No assets found for tag:${release.id}');
//     yield DisplayRelease(
//       release: release,
//       assets: null,
//     );
//   }
//
//   // send the latest release then send remaining tags
//   yield DisplayRelease(
//     release: release,
//     assets: repo.filterReleases(release),
//   );
//
//   if (release.id != null) {
//                   // skip the latest release
//     for (var x = release.id! - 1; x > release.id! - 5; x--) {
//       yield await getReleaseTag(slug: slug, repo: repo, tag: x);
//     }
//   }
// }
}

class CustomHttpClient extends http.BaseClient {
  CustomHttpClient(this._inner, this._defaultHeaders);

  final http.Client _inner;
  final Map<String, String> _defaultHeaders;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_defaultHeaders);
    logger.d(request);
    return _inner.send(request);
  }
}
