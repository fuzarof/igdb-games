import 'package:flutter/material.dart';
import 'package:igdb_games/core/services/database/database.dart';

abstract class IDatabaseHelper {
  AppDatabase? database;
  Future<void> init();
}

class DatabaseHelper implements IDatabaseHelper {
  @override
  AppDatabase? database;

  @override
  Future<void> init() async {
    try {
      database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    } catch (err) {
      debugPrint('Error loading from dotenv: $err');
    }
  }
}
