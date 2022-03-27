import 'package:get_it/get_it.dart';
import 'package:igdb_games/core/helpers/connectivity/connectivity_helper.dart';
import 'package:igdb_games/core/helpers/database/database.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/core/services/dio/igdb_custom_dio.dart';
import 'package:igdb_games/core/services/navigation/navigation_handler.dart';
import 'package:igdb_games/features/game/data/repositories/game_repository.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';
import 'package:igdb_games/features/game/presentation/detail/bloc/game_details_bloc.dart';
import 'package:igdb_games/features/game/presentation/list/bloc/game_list_bloc.dart';

GetIt inject = GetIt.I;

void setup() {
  // Helpers
  inject.registerLazySingleton<IDotEnvHelper>(() => DotEnvHelper());
  inject.registerLazySingleton<IConnectivityHelper>(() => ConnectivityHelper(inject.get()));
  inject.registerLazySingleton<IDatabaseHelper>(() => DatabaseHelper());

  // Services
  inject.registerLazySingleton<NavigationHandler>(() => NavigationHandler());
  inject.registerLazySingleton<IGDBCustomDio>(() => IGDBCustomDio());

  // Repositories
  inject.registerFactory<IGameRepository>(() => GameRepository(inject.get(), inject.get(), inject.get()));

  // Blocs
  inject.registerFactory<GameListBloc>(() => GameListBloc(inject.get()));
  inject.registerFactory<GameDetailsBloc>(() => GameDetailsBloc(inject.get()));
}
