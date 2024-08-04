import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rnr/utils/services.dart';
import 'package:rnr/services/settings.dart';


final settingsExistsProvider = FutureProvider<bool>((ref) async {
  return settings.isFirstInstall();
});
