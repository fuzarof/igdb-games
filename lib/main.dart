import 'package:flutter/material.dart';
import 'package:igdb_games/application/application.dart';
import 'package:igdb_games/core/helpers/connectivity/connectivity_helper.dart';
import 'package:igdb_games/core/helpers/database/database.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/injection_container.dart';

Future<void> main() async {
  setup();
  await inject.get<IDotEnvHelper>().init();
  await inject.get<IConnectivityHelper>().init();
  await inject.get<IDatabaseHelper>().init();
  runApp(const Application());
}
