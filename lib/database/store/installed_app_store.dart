import 'package:drift/drift.dart';
import 'package:rnr/database/store/display_app_store.dart';

/// Table to store metadata for apps
class InstalledAppStore extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Remote metadata
  /// repo name from where the app is installed
  TextColumn get repoName => text()();

  /// date of last installed release
  DateTimeColumn get lastRelease => dateTime()();

  /// [DisplayAppStore]
  IntColumn get remoteApp => integer().references(DisplayAppStore, #id)();

  // local metadata
  /// package name
  TextColumn get packageName => text()();
}
