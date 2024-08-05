import 'package:drift/drift.dart';

/// Table to describe apps shown in browse view
class DisplayAppStore extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get version => text()();

  TextColumn get name => text()();

  /// App architecture
  TextColumn get arch => text()();

  IntColumn get size => integer()();

  DateTimeColumn get releaseDate => dateTime()();

  TextColumn get downloadUrl => text()();
}
