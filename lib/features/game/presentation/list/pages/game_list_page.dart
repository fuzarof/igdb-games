import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igdb_games/core/services/navigation/navigation_handler.dart';
import 'package:igdb_games/core/widgets/custom_error/custom_error_widget.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GameListBloc _gameListBloc = inject.get<GameListBloc>();
  final TextEditingController _searchController = TextEditingController();
  final List<Game> _games = [];
  Timer? _debounce;
  int _page = 1;

  @override
  void initState() {
    _gameListBloc.add(LoadGameListEvent(page: _page));
    super.initState();
  }

  bool _onScroll(ScrollEndNotification scrollEndNotification) {
    final metrics = scrollEndNotification.metrics;
    if (metrics.atEdge && metrics.pixels != 0) {
      _fetchList(false);
    }
    return true;
  }

  _fetchList(bool refresh) {
    _page = refresh ? 1 : _page + 1;
    _gameListBloc.add(LoadGameListEvent(search: _searchController.text, page: _page));
  }

  _buildGameList(bool shimmer) {
    return ListView.builder(
      key: const Key('game_list_key'),
      padding: EdgeInsets.symmetric(vertical: (shimmer ? 0 : 24.0), horizontal: 0),
      itemCount: shimmer ? 10 : _games.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: ((context, index) {
        Game game = shimmer ? const Game.dummy() : _games[index];
        return Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            onTap: shimmer
                ? null
                : () => inject.get<NavigationHandler>().push('/details', arguments: {'game': game}),
            child: GameCardWidget(game: game, shimmer: shimmer),
          ),
        );
      }),
    );
  }

  _onSearchChanged(String? _) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchList(true);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context,
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ListAppBar(
              context,
              innerBoxIsScrolled: innerBoxIsScrolled,
              searchController: _searchController,
              onSend: _onSearchChanged,
            )
          ];
        },
        body: NotificationListener<ScrollEndNotification>(
          onNotification: _onScroll,
          child: RefreshIndicator(
            onRefresh: () async {
              _fetchList(true);
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<GameListBloc, GameListState>(
                  bloc: _gameListBloc,
                  builder: (context, state) {
                    if (state is GameListEmptyState) {
                      return Container(
                        padding: const EdgeInsets.only(top: 24.0),
                        width: double.infinity,
                        child: Text('No matches found',
                            style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                      );
                    }
                    if (state is GameListPendingState) {
                      return _buildGameList(true);
                    }
                    if (state is GameListRejectedState) {
                      return CustomError(title: state.message);
                    }
                    if (_page == 1) {
                      _games.clear();
                    }
                    if (state is GameListLoadedState) {
                      _games.addAll(state.games);
                    }
                    return Column(
                      children: [
                        _buildGameList(false),
                        Visibility(
                          visible: state is GameListPendingMoreState,
                          child: _buildGameList(true),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
