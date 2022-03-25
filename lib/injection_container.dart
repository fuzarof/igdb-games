import 'package:get_it/get_it.dart';
import 'package:igdb_games/core/helpers/dio/igdb_custom_dio.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/core/services/navigation_handler.dart';
import 'package:igdb_games/features/game/data/repositories/game_repository.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';
import 'package:igdb_games/features/game/presentation/list/bloc/game_list_bloc.dart';

GetIt inject = GetIt.I;

void setup() {
  inject.registerLazySingleton<IDotEnvHelper>(() => DotEnvHelper());
  inject.registerLazySingleton<NavigationHandler>(() => NavigationHandler());
  inject.registerLazySingleton<IGDBCustomDio>(() => IGDBCustomDio());

  inject.registerFactory<IGameRepository>(() => GameRepository(inject.get()));

  inject.registerFactory<GameListBloc>(() => GameListBloc(inject.get()));
}
