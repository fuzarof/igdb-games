import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';
import 'package:igdb_games/features/game/presentation/list/bloc/game_list_bloc.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$GameListBloc', () {
    late GameListBloc gameListBloc;
    late IGameRepository gameRepository;

    setUp(() {
      gameRepository = _MockGameRepository();
      gameListBloc = GameListBloc(gameRepository);
    });

    group('loadGames', () {
      final games = <Game>[
        _MockGame(),
      ];
      blocTest<GameListBloc, GameListState>(
        'should emit [ GameListPendingState, GameListLoadedState ] when all games are loaded',
        setUp: () => when(() => gameRepository.getGames(page: 1)).thenAnswer((_) async => games),
        build: () => gameListBloc,
        act: (bloc) => bloc.add(const LoadGameListEvent(page: 1)),
        expect: () => [GameListPendingState(), GameListLoadedState(games: games)],
      );
    });
    group('emptyGames', () {
      blocTest<GameListBloc, GameListState>(
        'should emit [ GameListPendingState, GameListEmptyState ] when all games are loaded',
        setUp: () => when(() => gameRepository.getGames(page: 1)).thenAnswer((_) async => []),
        build: () => gameListBloc,
        act: (bloc) => bloc.add(const LoadGameListEvent(page: 1)),
        expect: () => [GameListPendingState(), GameListEmptyState()],
      );
    });
    group('loadMoreGames', () {
      final games = <Game>[
        _MockGame(),
      ];
      blocTest<GameListBloc, GameListState>(
        'should emit [ GameListPendingMoreState, GameListLoadedState ] when all games are loaded',
        setUp: () => when(() => gameRepository.getGames(page: 2)).thenAnswer((_) async => games),
        build: () => gameListBloc,
        act: (bloc) => bloc.add(const LoadGameListEvent(page: 2)),
        expect: () => [GameListPendingMoreState(), GameListLoadedState(games: games)],
      );
    });
  });
}

class _MockGame extends Mock implements Game {}

class _MockGameRepository extends Mock implements IGameRepository {}
