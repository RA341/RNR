import 'package:flutter/material.dart';
import 'package:rnr/presentation/settings/settings.dart';
import 'package:rnr/utils/services.dart';
import 'package:rnr/utils/utils.dart';

class GithubPatInput extends StatefulWidget {
  const GithubPatInput({super.key});

  @override
  State<GithubPatInput> createState() => _GithubPatInputState();
}

class _GithubPatInputState extends State<GithubPatInput> {
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
    return Column(
      children: [
        const Text('Update Github personal access token'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: SizedBox(
            width: double.maxFinite,
            child: TextField(
              controller: githubTokenController,
            ),
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
    );
  }

  void updateState(bool newState) {
    setState(() {
      reqState = newState;
    });
  }
}
