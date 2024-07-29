import 'package:flutter/material.dart';
import 'package:rnr/repos/irepo.dart';

final repoList = <IRepo>[];

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
