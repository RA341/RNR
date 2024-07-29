import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/database/models/display_app.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/utils/services.dart';

final repoProvider =
    FutureProvider.autoDispose.family<List<DisplayApp>, IRepo>((
  ref,
  IRepo repo,
) async {
  final res = await git.getReleases(repo);
  return List.empty();
});
