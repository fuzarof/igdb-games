import 'dart:async';

import 'package:floor/floor.dart';
import 'package:igdb_games/core/helpers/type_converter/type_converter.dart';
import 'package:igdb_games/features/game/data/dao/game_dao.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@TypeConverters([GameCoverTypeConverter, ListGameScreenshotTypeConverter, ListGamePlatformTypeConverter])
@Database(version: 1, entities: [Game])
abstract class AppDatabase extends FloorDatabase {
  GameDao get gameDao;
}
