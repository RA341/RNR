import 'package:rnr/utils/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  SettingsManager(this.prefs);

  final SharedPreferences prefs;

  bool isGmsEnabled() {
    return prefs.getBool(SettingsKeys.gmsCore) ?? false;
  }

  Future<void> toggleGmsCore({required bool value}) async {
    await prefs.setBool(SettingsKeys.gmsCore, value);
    await prefs.reload();
  }


  String? getGithubToken() => prefs.getString(SettingsKeys.githubPat);

  Future<void> clearGithubToken() async {
    await prefs.remove(SettingsKeys.githubPat);
    await prefs.reload();
    if (getI.isRegistered(instance: git)) {
      getI.resetLazySingleton(
        instance: git,
        disposingFunction: (p0) {
          p0.dispose();
          logger.i('Github manager has been reset with github token removed');
        },
      );
    }
  }

  Future<void> updateGithubToken(String accessToken) async {
    await prefs.setString(SettingsKeys.githubPat, accessToken);
    await prefs.reload();
    if (getI.isRegistered(instance: git)) {
      getI.resetLazySingleton(
        instance: git,
        disposingFunction: (p0) {
          p0.dispose();
          logger.i('Github manager has been reset with new github token: ****'
              '${accessToken.substring((accessToken.length / 2).ceil())}');
        },
      );
    }
  }
}

class SettingsKeys {
  static const githubPat = 'github_pat';
  static const gmsCore = 'gmscore';
}
