import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rnr/presentation/settings/github_pat_input.dart';
import 'package:rnr/presentation/settings/gms_toggle.dart';
import 'package:rnr/utils/services.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('Settings', style: TextStyle(fontSize: 25),),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: GithubPatInput(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: EnableGmsCore(),
            ),
          ],
        ),
      ),
    );
  }
}
