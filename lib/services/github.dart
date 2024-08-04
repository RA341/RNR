import 'dart:async';
import 'package:github/github.dart';
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

  void dispose() {
    gitI.dispose();
  }

  Stream<DisplayRelease> getReleases(
    IRepo repo, {
    int page = 1,
    int perPage = 3,
  }) async* {
    final slug = RepositorySlug(
      repo.repoOwner,
      repo.repoName,
    );

    await for (final tag in collectTags(slug, page, perPage: perPage)) {
      logRateLimits();
      try {
        final release =
            await gitI.repositories.getReleaseByTagName(slug, tag.name);

        if (release.assets == null) {
          logger.w('No assets found for tag:${release.id}');
          yield DisplayRelease(
            release: release,
            assets: repo.filterReleases(release),
          );
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

  Stream<Tag> collectTags(
    RepositorySlug slug,
    int page, {
    int perPage = 3,
  }) async* {
    // VERY IMPORTANT ALWAYS PASS IN THE PAGES ARG ELSE IT WILL FETCH ALL PAGES
    yield* gitI.repositories.listTags(
      slug,
      page: page,
      pages: 1,
      perPage: perPage,
    );
  }

  void logRateLimits() {
    logger.i(
      'rateLimitLimit: ${gitI.rateLimitLimit ?? 0}\n'
      'rateLimitRemaining: ${gitI.rateLimitRemaining ?? 0}\n'
      'rateLimitReset: ${gitI.rateLimitReset ?? 0}',
    );
  }
}
