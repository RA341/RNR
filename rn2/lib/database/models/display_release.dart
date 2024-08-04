import 'package:github/github.dart';
import 'package:rnr/database/models/display_app.dart';

class DisplayRelease {
  DisplayRelease({required this.release, required this.assets});

  final Release release;
  final List<DisplayApp>? assets;
}
