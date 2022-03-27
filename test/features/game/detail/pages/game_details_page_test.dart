import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igdb_games/core/services/navigation/navigation_handler.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/presentation/detail/bloc/game_details_bloc.dart';
import 'package:igdb_games/features/game/presentation/detail/pages/game_details_page.dart';
import 'package:igdb_games/features/game/presentation/detail/widgets/detail_appbar_widget.dart';
import 'package:igdb_games/injection_container.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$GameDetailsPage', () {
    late GameDetailsBloc gameDetailsBloc;

    setUpAll(() => registerFallbackValue(GameDetailsPendingState()));

    setUp(() {
      gameDetailsBloc = _MockGameDetailsBloc();
      inject.registerLazySingleton<NavigationHandler>(() => NavigationHandler());
      inject.registerFactory(() => gameDetailsBloc);
    });

    testWidgets('render game details page', (tester) async {
      when(() => gameDetailsBloc.state).thenReturn(GameDetailsPendingState());
      await tester.pumpWidget(MaterialApp(
        home: GameDetailsPage(game: _MockGame()),
      ));
      expect(find.byType(DetailAppbar), findsOneWidget);
      expect(find.byKey(const Key('game_details_key')), findsOneWidget);
    });
  });
}

class _MockGame extends Mock implements Game {}

class _MockGameDetailsBloc extends MockBloc<GameDetailsEvent, GameDetailsState> implements GameDetailsBloc {}
