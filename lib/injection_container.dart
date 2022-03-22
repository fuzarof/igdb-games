import 'package:get_it/get_it.dart';
import 'package:igdb_games/core/helpers/dio/igdb_custom_dio.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/core/services/navigation_handler.dart';

GetIt inject = GetIt.I;

void setup() {
  inject.registerLazySingleton<IDotEnvHelper>(() => DotEnvHelper());
  inject.registerLazySingleton<NavigationHandler>(() => NavigationHandler());
  inject.registerLazySingleton<IGDBCustomDio>(() => IGDBCustomDio());
}
