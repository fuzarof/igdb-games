// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  GameDao? _gameDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `game` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `summary` TEXT, `cover` TEXT, `screenshots` TEXT, `platforms` TEXT, `similarGames` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }
}

class _$GameDao extends GameDao {
  _$GameDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _gameInsertionAdapter = InsertionAdapter(
            database,
            'game',
            (Game item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'summary': item.summary,
                  'cover': _gameCoverTypeConverter.encode(item.cover),
                  'screenshots':
                      _listGameScreenshotTypeConverter.encode(item.screenshots),
                  'platforms':
                      _listGamePlatformTypeConverter.encode(item.platforms),
                  'similarGames':
                      _listSimilarGamesTypeConverter.encode(item.similarGames)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Game> _gameInsertionAdapter;

  @override
  Future<List<Game>> findGamesLike(String search, int limit, int offset) async {
    return _queryAdapter.queryList(
        'SELECT * FROM game WHERE name LIKE ?1 LIMIT ?2 OFFSET ?3',
        mapper: (Map<String, Object?> row) => Game(
            id: row['id'] as int,
            name: row['name'] as String,
            summary: row['summary'] as String?,
            cover: _gameCoverTypeConverter.decode(row['cover'] as String?),
            screenshots: _listGameScreenshotTypeConverter
                .decode(row['screenshots'] as String?),
            platforms: _listGamePlatformTypeConverter
                .decode(row['platforms'] as String?),
            similarGames: _listSimilarGamesTypeConverter
                .decode(row['similarGames'] as String?)),
        arguments: [search, limit, offset]);
  }

  @override
  Future<List<Game>> findGamesInId(List<int> ids, int limit, int offset) async {
    const offset = 3;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM game WHERE id IN (' +
            _sqliteVariablesForIds +
            ') LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => Game(
            id: row['id'] as int,
            name: row['name'] as String,
            summary: row['summary'] as String?,
            cover: _gameCoverTypeConverter.decode(row['cover'] as String?),
            screenshots: _listGameScreenshotTypeConverter
                .decode(row['screenshots'] as String?),
            platforms: _listGamePlatformTypeConverter
                .decode(row['platforms'] as String?),
            similarGames: _listSimilarGamesTypeConverter
                .decode(row['similarGames'] as String?)),
        arguments: [limit, offset, ...ids]);
  }

  @override
  Future<void> insertGames(List<Game> game) async {
    await _gameInsertionAdapter.insertList(game, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _gameCoverTypeConverter = GameCoverTypeConverter();
final _listGameScreenshotTypeConverter = ListGameScreenshotTypeConverter();
final _listGamePlatformTypeConverter = ListGamePlatformTypeConverter();
final _listSimilarGamesTypeConverter = ListSimilarGamesTypeConverter();
