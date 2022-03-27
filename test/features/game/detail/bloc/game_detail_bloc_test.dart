import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';
import 'package:igdb_games/features/game/presentation/detail/bloc/game_details_bloc.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$GameDetailsBloc', () {
    late GameDetailsBloc gameDetailsBloc;
    late IGameRepository gameRepository;

    setUp(() {
      gameRepository = _MockGameRepository();
      gameDetailsBloc = GameDetailsBloc(gameRepository);
    });

    group('loadGames', () {
      final games = <Game>[
        _MockGame(),
      ];
      blocTest<GameDetailsBloc, GameDetailsState>(
        'should emit [ GameDetailsPendingState, GameDetailsLoadedState ] when all games are loaded',
        setUp: () => when(() => gameRepository.getGames(page: 1)).thenAnswer((_) async => games),
        build: () => gameDetailsBloc,
        act: (bloc) => bloc.add(const LoadRelatedGameListEvent()),
        expect: () => [GameDetailsPendingState(), GameDetailsLoadedState(similarGames: games)],
      );
    });
    group('emptyGames', () {
      blocTest<GameDetailsBloc, GameDetailsState>(
        'should emit [ GameDetailsPendingState, GameDetailsEmptyState ] when all games are loaded',
        setUp: () => when(() => gameRepository.getGames(page: 1)).thenAnswer((_) async => []),
        build: () => gameDetailsBloc,
        act: (bloc) => bloc.add(const LoadRelatedGameListEvent()),
        expect: () => [GameDetailsPendingState(), GameDetailsEmptyState()],
      );
    });
  });
}

class _MockGame extends Mock implements Game {}

class _MockGameRepository extends Mock implements IGameRepository {}
