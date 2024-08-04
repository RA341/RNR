import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/utils/services.dart';

final repoProvider = StateNotifierProvider.family<GithubReleaseNotifierS,
    List<DisplayRelease>, IRepo>(
  (ref, arg) {
    return GithubReleaseNotifierS(arg);
  },
);

class GithubReleaseNotifierS extends StateNotifier<List<DisplayRelease>> {
  GithubReleaseNotifierS(this.repo) : super([]) {
    _listenToReleaseStream(_page);
    _page++;
  }

  final IRepo repo;

  int _page = 1;

  Future<void> fetchMore() async {
    _listenToReleaseStream(_page++);
  }

  void _listenToReleaseStream(int page) {
    logger.d('Listening to releases');
    git.getReleases(repo, page: page).listen(
      (event) {
        state = [...state, event];
      },
    );
  }
}
