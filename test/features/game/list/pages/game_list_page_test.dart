import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igdb_games/features/game/presentation/list/bloc/game_list_bloc.dart';
import 'package:igdb_games/features/game/presentation/list/pages/game_list_page.dart';
import 'package:igdb_games/features/game/presentation/list/widgets/list_appbar_widget.dart';
import 'package:igdb_games/injection_container.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$GameListPage', () {
    late GameListBloc gameListBloc;

    setUpAll(() => registerFallbackValue(GameListPendingState()));

    setUp(() {
      gameListBloc = _MockGameListBloc();
      inject.registerFactory(() => gameListBloc);
    });

    testWidgets('render game list page', (tester) async {
      when(() => gameListBloc.state).thenReturn(GameListPendingState());
      await tester.pumpWidget(const MaterialApp(
        home: GameListPage(),
      ));
      expect(find.byType(ListAppBar), findsOneWidget);
      expect(find.byKey(const Key('game_list_key')), findsOneWidget);
    });
  });
}

class _MockGameListBloc extends MockBloc<GameListEvent, GameListState> implements GameListBloc {}
