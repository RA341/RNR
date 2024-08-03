import 'package:rnr/utils/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  SettingsManager(this.prefs);

  final SharedPreferences prefs;

  bool isFirstInstall() {
    try {
      final res = prefs.getBool('first_install')!;
      return !res;
    } catch (e) {
      logger.e('Failed to check "first_install" key in shared prefs', error: e);
      return true;
    }
  }

  String? getGithubToken() => prefs.getString('github_pat');

  Future<void> clearGithubToken() async {
    await prefs.remove('github_pat');
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
    await prefs.setString('github_pat', accessToken);
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
