import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igdb_games/core/services/navigation/navigation_handler.dart';
import 'package:igdb_games/core/widgets/custom_slider/carousel_slider.dart';
import 'package:igdb_games/core/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/presentation/detail/bloc/game_details_bloc.dart';
import 'package:igdb_games/features/game/presentation/detail/widgets/detail_appbar_widget.dart';
import 'package:igdb_games/features/game/presentation/detail/widgets/detail_missing_widget.dart';
import 'package:igdb_games/features/game/presentation/detail/widgets/detail_title_widget.dart';
import 'package:igdb_games/features/game/presentation/list/widgets/game_card_widget.dart';
import 'package:igdb_games/injection_container.dart';

class GameDetailsPage extends StatefulWidget {
  static const String route = "/details";

  final Game game;
  final bool? similarGame;

  const GameDetailsPage({Key? key, required this.game, this.similarGame = false}) : super(key: key);

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GameDetailsBloc _gameDetailsBloc = inject.get<GameDetailsBloc>();
  final List<Game> _relatedGames = [];

  @override
  void initState() {
    _gameDetailsBloc.add(LoadRelatedGameListEvent(ids: widget.game.similarGames));
    super.initState();
  }

  _buildSimilarGameList(bool shimmer) {
    return Column(
      children: [
        const DetailTitle(icon: FontAwesomeIcons.plus, title: 'Similar games'),
        ListView.builder(
          key: const Key('game_details_key'),
          padding: EdgeInsets.zero,
          itemCount: shimmer ? 10 : _relatedGames.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            Game game = shimmer ? const Game.dummy() : _relatedGames[index];
            return Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                onTap: shimmer
                    ? null
                    : () => inject
                        .get<NavigationHandler>()
                        .pushReplacement('/details', arguments: {'game': game}),
                child: GameCardWidget(
                  game: game,
                  shimmer: shimmer,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context,
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[DetailAppbar(context, innerBoxIsScrolled: innerBoxIsScrolled, game: widget.game)],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.game.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary.withOpacity(0.9)),
                    textAlign: TextAlign.center),
                widget.game.summary != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(widget.game.summary!,
                            style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left),
                      )
                    : Container(),
                const DetailTitle(icon: FontAwesomeIcons.star, title: 'Aggregated Rating'),
                Container(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  width: double.infinity,
                  child: widget.game.aggregatedRating != null
                      ? Text(
                          widget.game.aggregatedRating!.toStringAsFixed(2),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                              ),
                        )
                      : const DetailMissing(),
                ),
                const DetailTitle(icon: FontAwesomeIcons.gamepad, title: 'Platforms'),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  width: double.infinity,
                  child: widget.game.platforms != null
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.game.platforms!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.circle,
                                  size: 8,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    widget.game.platforms![index].name,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const DetailMissing(),
                ),
                const DetailTitle(icon: FontAwesomeIcons.images, title: 'Screenshots'),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: widget.game.screenshots != null
                        ? SizedBox(
                            height: 200,
                            child: CarouselSlider(
                              images: widget.game.screenshots!
                                  .map((screenshot) => screenshot.screenshot)
                                  .toList(),
                            ),
                          )
                        : const DetailMissing()),
                BlocBuilder<GameDetailsBloc, GameDetailsState>(
                  bloc: _gameDetailsBloc,
                  builder: (context, state) {
                    if (state is GameDetailsEmptyState || state is GameDetailsRejectedState) {
                      return Container();
                    }
                    if (state is GameDetailsPendingState) {
                      return _buildSimilarGameList(true);
                    }
                    if (state is GameDetailsLoadedState) {
                      _relatedGames.addAll(state.similarGames);
                    }
                    return _buildSimilarGameList(false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
