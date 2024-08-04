import 'package:flutter/material.dart';
import 'package:rnr/repos/irepo.dart';
import 'package:rnr/repos/sources/krvstek.rvx-apks.dart';
import 'package:rnr/repos/sources/revancedapks.buildapps.dart';

final repoList = <IRepo>[
  BuildApps(),
  RvxApks(),
];

final repoWidgets = () {
  final widList = <PopupMenuItem<int>>[];

  for (var x = 0; x < repoList.length; x++) {
    final e = repoList.elementAt(x);
    widList.add(
      PopupMenuItem<int>(
        value: x,
        child: Text('${e.repoOwner}/${e.repoName}'),
      ),
    );
  }
  return widList;
}();
