import 'package:dio/dio.dart';
import 'package:rnr/utils/services.dart';

double convertBytes(int bytes) => bytes / (1024 * 1024);

Future<bool> testToken(String token) async {
  final headers = {
    'Authorization': 'Bearer $token',
    'User-Agent': 'rnr-app',
  };
  try {
    final res = await Dio()
        .get('https://api.github.com/meta', options: Options(headers: headers));

    if (res.statusCode != 200) {
      logger.d(
          'Failed to test new github PAT error: statusCode= ${res.statusCode}'
          ', reason=${res.statusMessage}, body:${res.data}');
      return false;
    }
    return true;
  } catch (e) {
    logger.e(e);
    return false;
  }
}
