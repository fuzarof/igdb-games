import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igdb_games/core/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/presentation/list/bloc/game_list_bloc.dart';
import 'package:igdb_games/features/game/presentation/list/widgets/game_card_widget.dart';
import 'package:igdb_games/features/game/presentation/list/widgets/list_appbar_widget.dart';
import 'package:igdb_games/injection_container.dart';

class GameListPage extends StatefulWidget {
  static const String route = "/";

  const GameListPage({Key? key}) : super(key: key);

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  final GameListBloc _gameListBloc = inject.get<GameListBloc>();
  final TextEditingController _searchController = TextEditingController();
  final List<Game> _games = [];
  int _page = 1;

  @override
  void initState() {
    _gameListBloc.add(LoadGameListEvent(page: _page));
    super.initState();
  }

  bool _onScroll(ScrollEndNotification scrollEndNotification) {
    final metrics = scrollEndNotification.metrics;
    if (metrics.atEdge && metrics.pixels != 0) {
      _page++;
      _gameListBloc.add(
        LoadGameListEvent(search: _searchController.text, page: _page),
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ListAppBar(
              context,
              innerBoxIsScrolled: innerBoxIsScrolled,
              searchController: _searchController,
              onSend: () {
                _page = 1;
                _gameListBloc.add(
                  LoadGameListEvent(search: _searchController.text, page: _page),
                );
              },
            )
          ];
        },
        body: NotificationListener<ScrollEndNotification>(
          onNotification: _onScroll,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<GameListBloc, GameListState>(
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
                  if (_page == 1) {
                    _games.clear();
                  }
                  if (state is GameListLoadedState) {
                    _games.addAll(state.games);
                  }
                  return Column(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
                        itemCount: _games.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          Game game = _games[index];
                          return Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: GameCardWidget(game: game),
                          );
                        }),
                      ),
                      Visibility(
                        visible: state is GameListPendingMoreState,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
