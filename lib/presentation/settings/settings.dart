import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rnr/utils/services.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController githubTokenController;

  @override
  void initState() {
    super.initState();
    githubTokenController = TextEditingController();
  }

  @override
  void dispose() {
    githubTokenController.dispose();
    super.dispose();
  }

  var reqState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Update Github personal access token'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: SizedBox(
                width: double.maxFinite,
                child: TextField(controller: githubTokenController,),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                updateState(true);
                final token = githubTokenController.text;
                if (await testToken(token)) {
                  await settings.updateGithubToken(token);
                  updateState(false);
                  return;
                }

                updateState(false);
                if (!context.mounted) return;
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error verifying Github token!'),
                      content: const Text(
                        'The github token was incorrect, verify it and try again',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: reqState
                  ? const CircularProgressIndicator()
                  : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void updateState(bool newState) {
    setState(() {
      reqState = newState;
    });
  }
}

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
