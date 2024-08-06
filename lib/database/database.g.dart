// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DisplayAppStoreTable extends DisplayAppStore
    with TableInfo<$DisplayAppStoreTable, DisplayAppStoreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DisplayAppStoreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _archMeta = const VerificationMeta('arch');
  @override
  late final GeneratedColumn<String> arch = GeneratedColumn<String>(
      'arch', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
      'size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
      'release_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _downloadUrlMeta =
      const VerificationMeta('downloadUrl');
  @override
  late final GeneratedColumn<String> downloadUrl = GeneratedColumn<String>(
      'download_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, version, name, arch, size, releaseDate, downloadUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'display_app_store';
  @override
  VerificationContext validateIntegrity(
      Insertable<DisplayAppStoreData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('arch')) {
      context.handle(
          _archMeta, arch.isAcceptableOrUnknown(data['arch']!, _archMeta));
    } else if (isInserting) {
      context.missing(_archMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('download_url')) {
      context.handle(
          _downloadUrlMeta,
          downloadUrl.isAcceptableOrUnknown(
              data['download_url']!, _downloadUrlMeta));
    } else if (isInserting) {
      context.missing(_downloadUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DisplayAppStoreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DisplayAppStoreData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      arch: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arch'])!,
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}release_date'])!,
      downloadUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}download_url'])!,
    );
  }

  @override
  $DisplayAppStoreTable createAlias(String alias) {
    return $DisplayAppStoreTable(attachedDatabase, alias);
  }
}

class DisplayAppStoreData extends DataClass
    implements Insertable<DisplayAppStoreData> {
  final int id;
  final String version;
  final String name;

  /// App architecture
  final String arch;
  final int size;
  final DateTime releaseDate;
  final String downloadUrl;
  const DisplayAppStoreData(
      {required this.id,
      required this.version,
      required this.name,
      required this.arch,
      required this.size,
      required this.releaseDate,
      required this.downloadUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['version'] = Variable<String>(version);
    map['name'] = Variable<String>(name);
    map['arch'] = Variable<String>(arch);
    map['size'] = Variable<int>(size);
    map['release_date'] = Variable<DateTime>(releaseDate);
    map['download_url'] = Variable<String>(downloadUrl);
    return map;
  }

  DisplayAppStoreCompanion toCompanion(bool nullToAbsent) {
    return DisplayAppStoreCompanion(
      id: Value(id),
      version: Value(version),
      name: Value(name),
      arch: Value(arch),
      size: Value(size),
      releaseDate: Value(releaseDate),
      downloadUrl: Value(downloadUrl),
    );
  }

  factory DisplayAppStoreData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DisplayAppStoreData(
      id: serializer.fromJson<int>(json['id']),
      version: serializer.fromJson<String>(json['version']),
      name: serializer.fromJson<String>(json['name']),
      arch: serializer.fromJson<String>(json['arch']),
      size: serializer.fromJson<int>(json['size']),
      releaseDate: serializer.fromJson<DateTime>(json['releaseDate']),
      downloadUrl: serializer.fromJson<String>(json['downloadUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'version': serializer.toJson<String>(version),
      'name': serializer.toJson<String>(name),
      'arch': serializer.toJson<String>(arch),
      'size': serializer.toJson<int>(size),
      'releaseDate': serializer.toJson<DateTime>(releaseDate),
      'downloadUrl': serializer.toJson<String>(downloadUrl),
    };
  }

  DisplayAppStoreData copyWith(
          {int? id,
          String? version,
          String? name,
          String? arch,
          int? size,
          DateTime? releaseDate,
          String? downloadUrl}) =>
      DisplayAppStoreData(
        id: id ?? this.id,
        version: version ?? this.version,
        name: name ?? this.name,
        arch: arch ?? this.arch,
        size: size ?? this.size,
        releaseDate: releaseDate ?? this.releaseDate,
        downloadUrl: downloadUrl ?? this.downloadUrl,
      );
  DisplayAppStoreData copyWithCompanion(DisplayAppStoreCompanion data) {
    return DisplayAppStoreData(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
      name: data.name.present ? data.name.value : this.name,
      arch: data.arch.present ? data.arch.value : this.arch,
      size: data.size.present ? data.size.value : this.size,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      downloadUrl:
          data.downloadUrl.present ? data.downloadUrl.value : this.downloadUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DisplayAppStoreData(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('name: $name, ')
          ..write('arch: $arch, ')
          ..write('size: $size, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('downloadUrl: $downloadUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, version, name, arch, size, releaseDate, downloadUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DisplayAppStoreData &&
          other.id == this.id &&
          other.version == this.version &&
          other.name == this.name &&
          other.arch == this.arch &&
          other.size == this.size &&
          other.releaseDate == this.releaseDate &&
          other.downloadUrl == this.downloadUrl);
}

class DisplayAppStoreCompanion extends UpdateCompanion<DisplayAppStoreData> {
  final Value<int> id;
  final Value<String> version;
  final Value<String> name;
  final Value<String> arch;
  final Value<int> size;
  final Value<DateTime> releaseDate;
  final Value<String> downloadUrl;
  const DisplayAppStoreCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
    this.name = const Value.absent(),
    this.arch = const Value.absent(),
    this.size = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.downloadUrl = const Value.absent(),
  });
  DisplayAppStoreCompanion.insert({
    this.id = const Value.absent(),
    required String version,
    required String name,
    required String arch,
    required int size,
    required DateTime releaseDate,
    required String downloadUrl,
  })  : version = Value(version),
        name = Value(name),
        arch = Value(arch),
        size = Value(size),
        releaseDate = Value(releaseDate),
        downloadUrl = Value(downloadUrl);
  static Insertable<DisplayAppStoreData> custom({
    Expression<int>? id,
    Expression<String>? version,
    Expression<String>? name,
    Expression<String>? arch,
    Expression<int>? size,
    Expression<DateTime>? releaseDate,
    Expression<String>? downloadUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
      if (name != null) 'name': name,
      if (arch != null) 'arch': arch,
      if (size != null) 'size': size,
      if (releaseDate != null) 'release_date': releaseDate,
      if (downloadUrl != null) 'download_url': downloadUrl,
    });
  }

  DisplayAppStoreCompanion copyWith(
      {Value<int>? id,
      Value<String>? version,
      Value<String>? name,
      Value<String>? arch,
      Value<int>? size,
      Value<DateTime>? releaseDate,
      Value<String>? downloadUrl}) {
    return DisplayAppStoreCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
      name: name ?? this.name,
      arch: arch ?? this.arch,
      size: size ?? this.size,
      releaseDate: releaseDate ?? this.releaseDate,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (arch.present) {
      map['arch'] = Variable<String>(arch.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (downloadUrl.present) {
      map['download_url'] = Variable<String>(downloadUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DisplayAppStoreCompanion(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('name: $name, ')
          ..write('arch: $arch, ')
          ..write('size: $size, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('downloadUrl: $downloadUrl')
          ..write(')'))
        .toString();
  }
}

class $InstalledAppStoreTable extends InstalledAppStore
    with TableInfo<$InstalledAppStoreTable, InstalledAppStoreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstalledAppStoreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _repoNameMeta =
      const VerificationMeta('repoName');
  @override
  late final GeneratedColumn<String> repoName = GeneratedColumn<String>(
      'repo_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastReleaseMeta =
      const VerificationMeta('lastRelease');
  @override
  late final GeneratedColumn<DateTime> lastRelease = GeneratedColumn<DateTime>(
      'last_release', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _remoteAppMeta =
      const VerificationMeta('remoteApp');
  @override
  late final GeneratedColumn<int> remoteApp = GeneratedColumn<int>(
      'remote_app', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES display_app_store (id)'));
  static const VerificationMeta _packageNameMeta =
      const VerificationMeta('packageName');
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
      'package_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, repoName, lastRelease, remoteApp, packageName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installed_app_store';
  @override
  VerificationContext validateIntegrity(
      Insertable<InstalledAppStoreData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repo_name')) {
      context.handle(_repoNameMeta,
          repoName.isAcceptableOrUnknown(data['repo_name']!, _repoNameMeta));
    } else if (isInserting) {
      context.missing(_repoNameMeta);
    }
    if (data.containsKey('last_release')) {
      context.handle(
          _lastReleaseMeta,
          lastRelease.isAcceptableOrUnknown(
              data['last_release']!, _lastReleaseMeta));
    } else if (isInserting) {
      context.missing(_lastReleaseMeta);
    }
    if (data.containsKey('remote_app')) {
      context.handle(_remoteAppMeta,
          remoteApp.isAcceptableOrUnknown(data['remote_app']!, _remoteAppMeta));
    } else if (isInserting) {
      context.missing(_remoteAppMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
          _packageNameMeta,
          packageName.isAcceptableOrUnknown(
              data['package_name']!, _packageNameMeta));
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstalledAppStoreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstalledAppStoreData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      repoName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repo_name'])!,
      lastRelease: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_release'])!,
      remoteApp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_app'])!,
      packageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}package_name'])!,
    );
  }

  @override
  $InstalledAppStoreTable createAlias(String alias) {
    return $InstalledAppStoreTable(attachedDatabase, alias);
  }
}

class InstalledAppStoreData extends DataClass
    implements Insertable<InstalledAppStoreData> {
  final int id;

  /// repo name from where the app is installed
  final String repoName;

  /// date of last installed release
  final DateTime lastRelease;

  /// [DisplayAppStore]
  final int remoteApp;

  /// package name
  final String packageName;
  const InstalledAppStoreData(
      {required this.id,
      required this.repoName,
      required this.lastRelease,
      required this.remoteApp,
      required this.packageName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['repo_name'] = Variable<String>(repoName);
    map['last_release'] = Variable<DateTime>(lastRelease);
    map['remote_app'] = Variable<int>(remoteApp);
    map['package_name'] = Variable<String>(packageName);
    return map;
  }

  InstalledAppStoreCompanion toCompanion(bool nullToAbsent) {
    return InstalledAppStoreCompanion(
      id: Value(id),
      repoName: Value(repoName),
      lastRelease: Value(lastRelease),
      remoteApp: Value(remoteApp),
      packageName: Value(packageName),
    );
  }

  factory InstalledAppStoreData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstalledAppStoreData(
      id: serializer.fromJson<int>(json['id']),
      repoName: serializer.fromJson<String>(json['repoName']),
      lastRelease: serializer.fromJson<DateTime>(json['lastRelease']),
      remoteApp: serializer.fromJson<int>(json['remoteApp']),
      packageName: serializer.fromJson<String>(json['packageName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repoName': serializer.toJson<String>(repoName),
      'lastRelease': serializer.toJson<DateTime>(lastRelease),
      'remoteApp': serializer.toJson<int>(remoteApp),
      'packageName': serializer.toJson<String>(packageName),
    };
  }

  InstalledAppStoreData copyWith(
          {int? id,
          String? repoName,
          DateTime? lastRelease,
          int? remoteApp,
          String? packageName}) =>
      InstalledAppStoreData(
        id: id ?? this.id,
        repoName: repoName ?? this.repoName,
        lastRelease: lastRelease ?? this.lastRelease,
        remoteApp: remoteApp ?? this.remoteApp,
        packageName: packageName ?? this.packageName,
      );
  InstalledAppStoreData copyWithCompanion(InstalledAppStoreCompanion data) {
    return InstalledAppStoreData(
      id: data.id.present ? data.id.value : this.id,
      repoName: data.repoName.present ? data.repoName.value : this.repoName,
      lastRelease:
          data.lastRelease.present ? data.lastRelease.value : this.lastRelease,
      remoteApp: data.remoteApp.present ? data.remoteApp.value : this.remoteApp,
      packageName:
          data.packageName.present ? data.packageName.value : this.packageName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstalledAppStoreData(')
          ..write('id: $id, ')
          ..write('repoName: $repoName, ')
          ..write('lastRelease: $lastRelease, ')
          ..write('remoteApp: $remoteApp, ')
          ..write('packageName: $packageName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, repoName, lastRelease, remoteApp, packageName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstalledAppStoreData &&
          other.id == this.id &&
          other.repoName == this.repoName &&
          other.lastRelease == this.lastRelease &&
          other.remoteApp == this.remoteApp &&
          other.packageName == this.packageName);
}

class InstalledAppStoreCompanion
    extends UpdateCompanion<InstalledAppStoreData> {
  final Value<int> id;
  final Value<String> repoName;
  final Value<DateTime> lastRelease;
  final Value<int> remoteApp;
  final Value<String> packageName;
  const InstalledAppStoreCompanion({
    this.id = const Value.absent(),
    this.repoName = const Value.absent(),
    this.lastRelease = const Value.absent(),
    this.remoteApp = const Value.absent(),
    this.packageName = const Value.absent(),
  });
  InstalledAppStoreCompanion.insert({
    this.id = const Value.absent(),
    required String repoName,
    required DateTime lastRelease,
    required int remoteApp,
    required String packageName,
  })  : repoName = Value(repoName),
        lastRelease = Value(lastRelease),
        remoteApp = Value(remoteApp),
        packageName = Value(packageName);
  static Insertable<InstalledAppStoreData> custom({
    Expression<int>? id,
    Expression<String>? repoName,
    Expression<DateTime>? lastRelease,
    Expression<int>? remoteApp,
    Expression<String>? packageName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repoName != null) 'repo_name': repoName,
      if (lastRelease != null) 'last_release': lastRelease,
      if (remoteApp != null) 'remote_app': remoteApp,
      if (packageName != null) 'package_name': packageName,
    });
  }

  InstalledAppStoreCompanion copyWith(
      {Value<int>? id,
      Value<String>? repoName,
      Value<DateTime>? lastRelease,
      Value<int>? remoteApp,
      Value<String>? packageName}) {
    return InstalledAppStoreCompanion(
      id: id ?? this.id,
      repoName: repoName ?? this.repoName,
      lastRelease: lastRelease ?? this.lastRelease,
      remoteApp: remoteApp ?? this.remoteApp,
      packageName: packageName ?? this.packageName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repoName.present) {
      map['repo_name'] = Variable<String>(repoName.value);
    }
    if (lastRelease.present) {
      map['last_release'] = Variable<DateTime>(lastRelease.value);
    }
    if (remoteApp.present) {
      map['remote_app'] = Variable<int>(remoteApp.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstalledAppStoreCompanion(')
          ..write('id: $id, ')
          ..write('repoName: $repoName, ')
          ..write('lastRelease: $lastRelease, ')
          ..write('remoteApp: $remoteApp, ')
          ..write('packageName: $packageName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DisplayAppStoreTable displayAppStore =
      $DisplayAppStoreTable(this);
  late final $InstalledAppStoreTable installedAppStore =
      $InstalledAppStoreTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [displayAppStore, installedAppStore];
}

typedef $$DisplayAppStoreTableCreateCompanionBuilder = DisplayAppStoreCompanion
    Function({
  Value<int> id,
  required String version,
  required String name,
  required String arch,
  required int size,
  required DateTime releaseDate,
  required String downloadUrl,
});
typedef $$DisplayAppStoreTableUpdateCompanionBuilder = DisplayAppStoreCompanion
    Function({
  Value<int> id,
  Value<String> version,
  Value<String> name,
  Value<String> arch,
  Value<int> size,
  Value<DateTime> releaseDate,
  Value<String> downloadUrl,
});

class $$DisplayAppStoreTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DisplayAppStoreTable,
    DisplayAppStoreData,
    $$DisplayAppStoreTableFilterComposer,
    $$DisplayAppStoreTableOrderingComposer,
    $$DisplayAppStoreTableCreateCompanionBuilder,
    $$DisplayAppStoreTableUpdateCompanionBuilder> {
  $$DisplayAppStoreTableTableManager(
      _$AppDatabase db, $DisplayAppStoreTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DisplayAppStoreTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DisplayAppStoreTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> arch = const Value.absent(),
            Value<int> size = const Value.absent(),
            Value<DateTime> releaseDate = const Value.absent(),
            Value<String> downloadUrl = const Value.absent(),
          }) =>
              DisplayAppStoreCompanion(
            id: id,
            version: version,
            name: name,
            arch: arch,
            size: size,
            releaseDate: releaseDate,
            downloadUrl: downloadUrl,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String version,
            required String name,
            required String arch,
            required int size,
            required DateTime releaseDate,
            required String downloadUrl,
          }) =>
              DisplayAppStoreCompanion.insert(
            id: id,
            version: version,
            name: name,
            arch: arch,
            size: size,
            releaseDate: releaseDate,
            downloadUrl: downloadUrl,
          ),
        ));
}

class $$DisplayAppStoreTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DisplayAppStoreTable> {
  $$DisplayAppStoreTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get version => $state.composableBuilder(
      column: $state.table.version,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get arch => $state.composableBuilder(
      column: $state.table.arch,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get size => $state.composableBuilder(
      column: $state.table.size,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get downloadUrl => $state.composableBuilder(
      column: $state.table.downloadUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter installedAppStoreRefs(
      ComposableFilter Function($$InstalledAppStoreTableFilterComposer f) f) {
    final $$InstalledAppStoreTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.installedAppStore,
            getReferencedColumn: (t) => t.remoteApp,
            builder: (joinBuilder, parentComposers) =>
                $$InstalledAppStoreTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.installedAppStore,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$DisplayAppStoreTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DisplayAppStoreTable> {
  $$DisplayAppStoreTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get version => $state.composableBuilder(
      column: $state.table.version,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get arch => $state.composableBuilder(
      column: $state.table.arch,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get size => $state.composableBuilder(
      column: $state.table.size,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get downloadUrl => $state.composableBuilder(
      column: $state.table.downloadUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$InstalledAppStoreTableCreateCompanionBuilder
    = InstalledAppStoreCompanion Function({
  Value<int> id,
  required String repoName,
  required DateTime lastRelease,
  required int remoteApp,
  required String packageName,
});
typedef $$InstalledAppStoreTableUpdateCompanionBuilder
    = InstalledAppStoreCompanion Function({
  Value<int> id,
  Value<String> repoName,
  Value<DateTime> lastRelease,
  Value<int> remoteApp,
  Value<String> packageName,
});

class $$InstalledAppStoreTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InstalledAppStoreTable,
    InstalledAppStoreData,
    $$InstalledAppStoreTableFilterComposer,
    $$InstalledAppStoreTableOrderingComposer,
    $$InstalledAppStoreTableCreateCompanionBuilder,
    $$InstalledAppStoreTableUpdateCompanionBuilder> {
  $$InstalledAppStoreTableTableManager(
      _$AppDatabase db, $InstalledAppStoreTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$InstalledAppStoreTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$InstalledAppStoreTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> repoName = const Value.absent(),
            Value<DateTime> lastRelease = const Value.absent(),
            Value<int> remoteApp = const Value.absent(),
            Value<String> packageName = const Value.absent(),
          }) =>
              InstalledAppStoreCompanion(
            id: id,
            repoName: repoName,
            lastRelease: lastRelease,
            remoteApp: remoteApp,
            packageName: packageName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String repoName,
            required DateTime lastRelease,
            required int remoteApp,
            required String packageName,
          }) =>
              InstalledAppStoreCompanion.insert(
            id: id,
            repoName: repoName,
            lastRelease: lastRelease,
            remoteApp: remoteApp,
            packageName: packageName,
          ),
        ));
}

class $$InstalledAppStoreTableFilterComposer
    extends FilterComposer<_$AppDatabase, $InstalledAppStoreTable> {
  $$InstalledAppStoreTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get repoName => $state.composableBuilder(
      column: $state.table.repoName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastRelease => $state.composableBuilder(
      column: $state.table.lastRelease,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get packageName => $state.composableBuilder(
      column: $state.table.packageName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$DisplayAppStoreTableFilterComposer get remoteApp {
    final $$DisplayAppStoreTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.remoteApp,
            referencedTable: $state.db.displayAppStore,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$DisplayAppStoreTableFilterComposer(ComposerState($state.db,
                    $state.db.displayAppStore, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$InstalledAppStoreTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $InstalledAppStoreTable> {
  $$InstalledAppStoreTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get repoName => $state.composableBuilder(
      column: $state.table.repoName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastRelease => $state.composableBuilder(
      column: $state.table.lastRelease,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get packageName => $state.composableBuilder(
      column: $state.table.packageName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$DisplayAppStoreTableOrderingComposer get remoteApp {
    final $$DisplayAppStoreTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.remoteApp,
            referencedTable: $state.db.displayAppStore,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$DisplayAppStoreTableOrderingComposer(ComposerState($state.db,
                    $state.db.displayAppStore, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DisplayAppStoreTableTableManager get displayAppStore =>
      $$DisplayAppStoreTableTableManager(_db, _db.displayAppStore);
  $$InstalledAppStoreTableTableManager get installedAppStore =>
      $$InstalledAppStoreTableTableManager(_db, _db.installedAppStore);
}
