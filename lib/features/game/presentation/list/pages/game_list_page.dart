import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/presentation/list/bloc/game_list_bloc.dart';
import 'package:igdb_games/injection_container.dart';

class GameListPage extends StatefulWidget {
  static const String route = "/";

  const GameListPage({Key? key}) : super(key: key);

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  final GameListBloc _gameListBloc = inject.get<GameListBloc>();

  @override
  void initState() {
    _gameListBloc.add(LoadGameListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("IGDB Games")),
        body: BlocBuilder<GameListBloc, GameListState>(
          bloc: _gameListBloc,
          builder: (context, state) {
            if (state is GameListEmptyState) {
              return const Text('Empty list');
            }
            if (state is GameListPendingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GameListRejectedState) {
              return Center(child: Text(state.message));
            }

            List<Game> games = (state as GameListLoadedState).games;
            return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final Game game = games[index];
                  return Text(game.name);
                });
          },
        ));
  }
}
