import 'package:flutter/material.dart';
import 'package:rnr/presentation/home/gmscore_widget.dart';
import 'package:rnr/repos/sources/Revanced.GmsCore.dart';
import 'package:rnr/utils/services.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GmsCoreWidget()

        ],
      ),
    );
  }
}
