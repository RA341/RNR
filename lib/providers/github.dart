import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/utils/services.dart';

final repoProvider = StateNotifierProvider.autoDispose
    .family<GithubReleaseNotifierS, List<DisplayRelease>, IRepo>(
  (ref, arg) {
    final repo = RepoPage(repo: arg);
    ref.watch(assetProvider(repo));

    return GithubReleaseNotifierS(arg);
  },
);

final assetProvider = StreamProvider.autoDispose
    .family<DisplayRelease, RepoPage>((ref, RepoPage arg) async* {
  git.getReleasesS(arg.repo, page: arg.page);
});

/// Utility class to pass [IRepo] and page to riverpod family providers
class RepoPage {
  const RepoPage({required this.repo, this.page = 1});

  final IRepo repo;

  final int page;

  @override
  bool operator ==(Object other) {
    return other is RepoPage &&
        other.runtimeType == runtimeType &&
        other.repo.repoName == repo.repoName &&
        other.repo.repoOwner == repo.repoOwner &&
        other.page == page;
  }

  @override
  int get hashCode => super.hashCode;
}

class GithubReleaseNotifierS extends StateNotifier<List<DisplayRelease>> {
  GithubReleaseNotifierS(this.repo) : super([]) {
    initStream();
    _listenToAppRelease();
  }

  final IRepo repo;

  int _page = 1;

  Future<void> fetchMore() async {
    git.getReleasesS(repo, page: _page++);
  }

  void _listenToAppRelease() {
    logger.d('Listening to evens');
    git.appStream.stream.listen(
      (event) {
        state = [...state, event];
      },
    );
  }

  void initStream() {
    git.getReleasesS(repo, page: _page);
  }
}
