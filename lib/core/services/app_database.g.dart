// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TriageDao? _triageDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TriageRecord` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `age` INTEGER NOT NULL, `gender` TEXT NOT NULL, `symptoms` TEXT NOT NULL, `temperature` REAL NOT NULL, `heartRate` INTEGER NOT NULL, `respiratoryRate` INTEGER NOT NULL, `bloodPressure` TEXT NOT NULL, `triageLevel` TEXT NOT NULL, `timestamp` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TriageDao get triageDao {
    return _triageDaoInstance ??= _$TriageDao(database, changeListener);
  }
}

class _$TriageDao extends TriageDao {
  _$TriageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _triageRecordInsertionAdapter = InsertionAdapter(
            database,
            'TriageRecord',
            (TriageRecord item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age,
                  'gender': item.gender,
                  'symptoms': item.symptoms,
                  'temperature': item.temperature,
                  'heartRate': item.heartRate,
                  'respiratoryRate': item.respiratoryRate,
                  'bloodPressure': item.bloodPressure,
                  'triageLevel': item.triageLevel,
                  'timestamp': item.timestamp
                }),
        _triageRecordDeletionAdapter = DeletionAdapter(
            database,
            'TriageRecord',
            ['id'],
            (TriageRecord item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age,
                  'gender': item.gender,
                  'symptoms': item.symptoms,
                  'temperature': item.temperature,
                  'heartRate': item.heartRate,
                  'respiratoryRate': item.respiratoryRate,
                  'bloodPressure': item.bloodPressure,
                  'triageLevel': item.triageLevel,
                  'timestamp': item.timestamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TriageRecord> _triageRecordInsertionAdapter;

  final DeletionAdapter<TriageRecord> _triageRecordDeletionAdapter;

  @override
  Future<List<TriageRecord>> getAllRecords() async {
    return _queryAdapter.queryList(
        'SELECT * FROM TriageRecord ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => TriageRecord(
            id: row['id'] as String,
            name: row['name'] as String,
            age: row['age'] as int,
            gender: row['gender'] as String,
            symptoms: row['symptoms'] as String,
            temperature: row['temperature'] as double,
            heartRate: row['heartRate'] as int,
            respiratoryRate: row['respiratoryRate'] as int,
            bloodPressure: row['bloodPressure'] as String,
            triageLevel: row['triageLevel'] as String,
            timestamp: row['timestamp'] as String));
  }

  @override
  Future<void> insertRecord(TriageRecord record) async {
    await _triageRecordInsertionAdapter.insert(
        record, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRecord(TriageRecord record) async {
    await _triageRecordDeletionAdapter.delete(record);
  }
}
