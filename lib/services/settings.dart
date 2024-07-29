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
}
