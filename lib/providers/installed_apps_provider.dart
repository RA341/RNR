
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/app_info.dart';
import 'package:rnr/services/app_manager.dart';
import 'package:rnr/utils/services.dart';

final installedAppsProvider = FutureProvider<List<AppInfo>>((ref) async {
  return appMan.getAllApps();
}
);

final queryProvider = StateProvider<String>((ref) {
  return '';
});

final searchProvider = Provider<List<AppInfo>>((ref) {
  try {
    final apps = ref
        .watch(installedAppsProvider)
        .requireValue;
    final query = ref.watch(queryProvider);
    return searchApps(query, apps);
  } catch (e) {
    logger
      ..e(e)
      ..d(
        'Search provider errored out, this is expected '
            'probably trying to read searchProvider before results are retrieved',);
    return [];
  }
});

List<AppInfo> searchApps(String query, List<AppInfo> apps) {
  if (query.isEmpty) {
    return [];
  }

  // no results when no apps present

  final results = <AppInfo>[];

  // for (final app in apps) {
  //   if (app.packageName.contains(query) || app.appName.contains(query)) {
  //     results.add(app);
  //   }
  // }

  return results;
}
