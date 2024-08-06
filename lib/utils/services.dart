/// Initializes singletons in services/
library;

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:github/github.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rnr/database/database.dart';
import 'package:rnr/presentation/settings/settings.dart';
import 'package:rnr/services/app_manager.dart';
import 'package:rnr/services/github.dart';
import 'package:rnr/services/settings.dart';
import 'package:rnr/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getI = GetIt.instance;

final reg = getI.registerLazySingleton;
final get = getI.get;

final logger = get<Logger>();
final settings = get<SettingsManager>();

final git = GithubManger.i;

Future<void> initServices() async {
  final extDir = await getExternalStorageDirectory();
  final logFile = await File('${extDir!.path}/rnr.log').create(recursive: true);

  // todo make 2 loggers for dev and prod
  final logger = Logger(
    level: Level.all,
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    output: kDebugMode ? ConsoleOutput() : FileOutput(file: logFile),
    printer: PrettyPrinter(
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );
  reg<Logger>(() => logger);

  reg<AppDatabase>(AppDatabase.new);

  final prefs = await SharedPreferences.getInstance();
  reg<SettingsManager>(() => SettingsManager(prefs));

  if (git.gitI.auth.bearerToken != null &&
      !await testToken(git.gitI.auth.bearerToken!)) {
    logger.d('Invalid Github token detected removing token');
    await settings.clearGithubToken();
  }
}
