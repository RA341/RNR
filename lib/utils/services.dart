/// Initializes singletons in services/
library;

import 'package:get_it/get_it.dart';
import 'package:github/github.dart';
import 'package:logger/logger.dart';
import 'package:rnr/presentation/settings/settings.dart';
import 'package:rnr/services/github.dart';
import 'package:rnr/services/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getI = GetIt.instance;

final reg = getI.registerLazySingleton;
final get = getI.get;

final logger = get<Logger>();
final settings = get<SettingsManager>();

final git = GithubManger.i;

Future<void> initServices() async {
  final logger = Logger(
    printer: PrettyPrinter(
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );
  reg<Logger>(() => logger);

  final prefs = await SharedPreferences.getInstance();
  reg<SettingsManager>(() => SettingsManager(prefs));

  if (!await testToken(git.gitI.auth.bearerToken!)) {
    logger.d('Invalid Github token detected removing token');
    await settings.clearGithubToken();
  }
}
