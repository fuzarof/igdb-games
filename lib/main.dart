import 'package:flutter/material.dart';
import 'package:igdb_games/application/application.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/injection_container.dart';

Future<void> main() async {
  setup();
  await inject.get<IDotEnvHelper>().init();
  runApp(const Application());
}
