import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/utils/services.dart';

final repoIndexProvider = StateProvider<int>((ref) => 0);

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
  bool isLoading = false;

  Future<void> fetchMore() async {
    if (!isLoading) {
      _listenToReleaseStream(_page++);
    }
  }

  @override
  void dispose() {
    _page = 1;
    print('disposering');
    super.dispose();
  }

  void _listenToReleaseStream(int page) {
    isLoading = true;
    git.getReleases(repo, page: page).listen(
      (event) {
        state = [...state, event];
      },
      onError: (Object err, StackTrace st) {
        logger.e('Stream error',error: err,stackTrace: st);
        isLoading = false;
      },
      onDone: () {
        isLoading = false;
      },
    );
  }
}
